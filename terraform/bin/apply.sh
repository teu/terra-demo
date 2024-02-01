#!/usr/bin/env bash

set -e
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
ENVIRONMENT=$1
REGION=$2
TF_STATE=$3

if [ "$ENVIRONMENT" != "dev" ] || [ "$REGION" != "eu-central-1" ]; then
  echo "Wrong env/region."
  exit 1
fi


source "${SCRIPTPATH}/shared/${ENVIRONMENT}.conf"

TFVARS="${ENVIRONMENT}-${REGION}"
PLAN="${TF_STATE}-${TFVARS}"

cd ${SCRIPTPATH}/../states/${TF_STATE}/

# set default profile
AWS_PROFILE=${PROFILE}

# clean cache
rm -rf .terraform

# initialize terraform
yes yes | terraform init -upgrade -backend-config=region=${STATE_BUCKET_REGION} \
-var aws_profile=${AWS_PROFILE} \
-backend-config=bucket=${STATE_BUCKET} -backend-config=key=${TF_STATE}/${TFVARS}.tfstate

# generate plan
terraform plan -parallelism=${PARALELLISM} -var "aws_profile=${AWS_PROFILE}" \
-var aws_account_id=${AWS_ACCOUNT_ID} \
-var terraform_state_bucket=${STATE_BUCKET} \
-var terraform_state_bucket_region=${STATE_BUCKET_REGION} \
-var max_retries=${TF_MAX_RETRIES} \
-var-file=${TFVARS}.tfvars  ${EXECUTION_TARGET} \
-out=${PLAN}.plan

# yes/no
read -p "Are you sure? Yy" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Applying..."
    terraform apply -parallelism=${PARALELLISM} ${PLAN}.plan
fi

# cleanup
rm ${PLAN}.plan

cd -
