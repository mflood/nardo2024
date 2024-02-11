#!/bin/bash

# Variables
apiName="Nardo2024API"
lambdaFunctionName="nardo2024-room-data-static"
lambdaFunctionArn="arn:aws:lambda:us-west-2:984385465437:function:nardo2024-room-data-static"
region="us-west-2"

source api_config.sh

# Step 4: Create a GET Method on the new resource
aws apigateway put-method --rest-api-id $apiId --region $region --resource-id $resourceId --http-method POST --authorization-type NONE --no-api-key-required 

# Step 5: Set up the Integration Request
# this choked

aws apigateway put-integration --rest-api-id $apiId --region $region --resource-id $resourceId --http-method POST --type AWS --integration-http-method POST --uri "arn:aws:apigateway:$region:lambda:path/2015-03-31/functions/$lambdaFunctionArn/invocations"

aws apigateway put-integration --rest-api-id $apiId --region $region --resource-id $resourceId --http-method POST --type AWS --integration-http-method POST --uri 'arn:aws:apigateway:us-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:us-west-2:984385465437:function:nardo2024-room-data-static/invocations'

