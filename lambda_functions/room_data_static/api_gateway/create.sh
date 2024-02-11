#!/bin/bash

# Variables
apiName="Nardo2024API"
lambdaFunctionName="nardo2024-room-data-static"
lambdaFunctionArn="arn:aws:lambda:us-west-2:984385465437:function:nardo2024-room-data-static"
region="us-west-2"

source api_config.sh


# Step 1: Create an API Gateway REST API
apiId=$(aws apigateway create-rest-api --name "$apiName" --region $region --query 'id' --output text)
echo "export apiId=$apiId" >> api_config.sh

# Step 2: Get the root resource ID
rootResourceId=$(aws apigateway get-resources --rest-api-id $apiId --region $region --query 'items[?path==`/`].id' --output text)
echo "export rootResourceId=$rootResourceId" >> api_config.sh

# Step 3: Create a Resource
resourceId=$(aws apigateway create-resource --rest-api-id $apiId --region $region --parent-id $rootResourceId --path-part "roomdata" --query 'id' --output text)
echo "export resourceId=$resourceId" >> api_config.sh


# Step 4: Create a GET Method on the new resource
aws apigateway put-method --rest-api-id $apiId --region $region --resource-id $resourceId --http-method POST --authorization-type NONE --no-api-key-required 

# Step 5: Set up the Integration Request
# this choked

aws apigateway put-integration --rest-api-id $apiId --region $region --resource-id $resourceId --http-method POST --type AWS --integration-http-method POST --uri "arn:aws:apigateway:$region:lambda:path/2015-03-31/functions/$lambdaFunctionArn/invocations"

aws apigateway put-integration --rest-api-id $apiId --region $region --resource-id $resourceId --http-method POST --type AWS --integration-http-method POST --uri 'arn:aws:apigateway:us-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:us-west-2:984385465437:function:nardo2024-room-data-static/invocations'


# Step 6: Grant API Gateway permission to invoke the Lambda function
aws lambda add-permission --function-name $lambdaFunctionName --statement-id apigateway-test-$(date +%s) --action lambda:InvokeFunction --principal apigateway.amazonaws.com --source-arn "arn:aws:execute-api:$region:984385465437:$apiId/*/*/*"

# Step 7: Deploy the API
deploymentId=$(aws apigateway create-deployment --rest-api-id $apiId --region $region --stage-name prod --query 'id' --output text)
echo "export deploymentId=$deploymentId" >> api_config.sh

# Output the invoke URL
echo "Invoke URL: https://$apiId.execute-api.$region.amazonaws.com/prod/roomdata"

