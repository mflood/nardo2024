#!/bin/bash

# Variables
apiName="Nardo2024API"
lambdaFunctionName="nardo2024-room-data-static"
lambdaFunctionArn="arn:aws:lambda:us-west-2:984385465437:function:nardo2024-room-data-static"
region="us-west-2"

source api_config.sh


# Step 6: Grant API Gateway permission to invoke the Lambda function
aws lambda add-permission --function-name $lambdaFunctionName --statement-id apigateway-test-$(date +%s) --action lambda:InvokeFunction --principal apigateway.amazonaws.com --source-arn "arn:aws:execute-api:$region:984385465437:$apiId/*/*/*"

