


mkdir -p lambda_package
#pip install redis -t lambda_package/
cp lambda_function.py lambda_package/
cp backup.json lambda_package/


(cd lambda_package; zip -r ../my_lambda_function.zip ./)
