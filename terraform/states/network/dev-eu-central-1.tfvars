environment = "dev"
default_aws_tags = {
  Environment = "dev"
  Owner       = "terraform"
}
aws_region = "eu-central-1"
vpc_cidr   = "10.2.0.0/16"
availability_zones = [
  "eu-central-1a",
  "eu-central-1b"
] # no need to have 3 AZs in dev
private_subnet_cidrs = [
  "10.2.32.0/21",
  "10.2.48.0/20"
]
public_subnet_cidrs = [
  "10.2.0.0/22",
  "10.2.4.0/22"
]
