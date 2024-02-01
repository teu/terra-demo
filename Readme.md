# Demo terraform aws infra and ECS-based app

### To run

1. Create AWS account and configure AWS CLI
2. Create S3 bucket for terraform state
3. Create domain manually
4. Set bin/shared/[env].conf with variables required

Run terraform commands:

```
./terraform/bin/apply.sh [env] [region] [state]
```

### State precedence

For the first run, this is the dependency sequence.

1. network
2. app

### Assumptions

1. ECS base app
2. Multiple environment and region ready
3. Multip-state setup
4. No CI/CD
5. No autoscaling
6. No monitoring
7. Nothing fancy

### Possible improvements

- Use terraform modules more extensively, remove LB from ECS module. Externalize when needed.
- Remove dependency on 3rd party vpc module.
- Add declarative CI/CD pipeline.
- Move to terraform cloud for state management.
- Add terratest.
- Split db state. Add ability to run from snapshot.
- Add monitoring and alerting with CW.
- Add autoscaling.
- Move DB to Aurora.
- Externalize secrets to KMS.

