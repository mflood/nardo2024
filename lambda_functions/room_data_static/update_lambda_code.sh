


./bundle.sh
source lambda_config.sh

aws lambda update-function-code --function-name $FUNCTION_NAME --zip-file fileb://my_lambda_function.zip

