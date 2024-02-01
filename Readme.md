# Demo terraform aws infra and ECS-based app

### To run

1. Create AWS account and configure AWS CLI
2. Create S3 bucket for terraform state
3. Create domain manually
4. Set bin/shared/[env].conf with variables required


Run terraform commands:
```
./bin/apply.sh [env] [region] [state]
```

### State precedence

For the first run, this is the dependancy sequence.

1. network
2. app

### Possible improvements

1. Use terraform modules more extensively, remove LB from ECS module
2. 
