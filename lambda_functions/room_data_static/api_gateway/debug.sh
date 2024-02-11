#!/bin/bash

lambdaFunctionArn="arn:aws:lambda:us-west-2:984385465437:function:nardo2024-room-data-static"
region="us-west-2"
source api_config.sh

# Step 5: Set up the Integration Request
aws apigateway put-integration --rest-api-id $apiId --region $region --resource-id $resourceId --http-method GET --type AWS --integration-http-method POST \
 --uri "arn:aws:apigateway:$region:lambda:path/2015-03-31/functions/$lambdaFunctionArn/invocations"

aws apigateway put-integration --rest-api-id $apiId --region $region --resource-id $resourceId --http-method GET --type AWS --integration-http-method POST \
 --uri 'arn:aws:apigateway:us-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:us-west-2:984385465437:function:nardo2024-room-data-static/invocations'


