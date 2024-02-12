#!/bin/bash

# Get list of all Lambda functions
function_list=$(aws lambda list-functions | jq -r '.Functions[].FunctionName')

# Loop through the list and get IAM role for each function
for function_name in $function_list
do
    echo "Function: $function_name"
    aws lambda get-function --function-name $function_name | jq -r '.Configuration.Role'
done

