



FUNCTION_NAME=nardo2024-restore-backup

aws lambda update-function-code --function-name $FUNCTION_NAME --zip-file fileb://my_lambda_function.zip

