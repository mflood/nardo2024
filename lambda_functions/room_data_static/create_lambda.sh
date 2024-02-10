
source lambda_config.sh

aws lambda create-function --function-name "$FUNCTION_NAME" \
--runtime python3.12 --role "$LAMBDA_ROLE" \
--handler lambda_function.lambda_handler --zip-file fileb://my_lambda_function.zip

