
source ../lambda_config.sh


aws lambda invoke \
--function-name $FUNCTION_NAME \
--payload file://payload.json \
--cli-binary-format raw-in-base64-out \
output.txt


echo "api call results are in output.txt"


