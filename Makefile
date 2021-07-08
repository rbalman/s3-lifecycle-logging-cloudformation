MAKE_ARGS:=--profile $(AWS_PROFILE) --region $(AWS_REGION)

ACCOUNT_ID:=$(shell aws sts get-caller-identity $(MAKE_ARGS) --output text --query 'Account')
STACK_NAME:=s3-life-cycle-versioning
SRC_BKT_NAME:=balman-completely-random

create-stack:
	aws cloudformation create-stack --stack-name $(STACK_NAME) --template-body file://bucket.yaml --parameters ParameterKey=SourceBucketName,ParameterValue=$(SRC_BKT_NAME) --capabilities CAPABILITY_IAM $(MAKE_ARGS)

update-stack:
	aws cloudformation update-stack --stack-name $(STACK_NAME) --template-body file://bucket.yaml --parameters ParameterKey=SourceBucketName,ParameterValue=$(SRC_BKT_NAME) --capabilities CAPABILITY_IAM $(MAKE_ARGS)

delete-stack:
	aws cloudformation delete-stack --stack-name $(STACK_NAME) $(MAKE_ARGS)

wait-delete:
	aws cloudformation wait stack-delete-complete --stack-name $(STACK_NAME) $(MAKE_ARGS)

s3-upload:
	aws s3 cp tests/files s3://$(SRC_BKT_NAME)/files --recursive $(MAKE_ARGS)