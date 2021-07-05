MAKE_ARGS:=--profile $(AWS_PROFILE) --region $(AWS_REGION)

STACK_NAME:=s3-life-cycle-versioning

create-stack:
	aws cloudformation create-stack --stack-name $(STACK_NAME) --template-body file://bucket.yaml --parameters ParameterKey=SourceBucketName,ParameterValue=balman-completely-random --capabilities CAPABILITY_IAM $(MAKE_ARGS)

update-stack:
	aws cloudformation update-stack --stack-name $(STACK_NAME) --template-body file://bucket.yaml --parameters ParameterKey=SourceBucketName,ParameterValue=balman-completely-random --capabilities CAPABILITY_IAM $(MAKE_ARGS)

delete-stack:
	aws cloudformation delete-stack --stack-name $(STACK_NAME) $(MAKE_ARGS)

wait-delete:
	aws cloudformation wait stack-delete-complete --stack-name $(STACK_NAME) $(MAKE_ARGS)