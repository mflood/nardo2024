
source lambda_config.sh

aws lambda update-function-configuration --function-name $FUNCTION_NAME --timeout 3
