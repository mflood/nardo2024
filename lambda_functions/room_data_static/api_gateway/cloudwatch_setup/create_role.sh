aws iam create-role \
  --role-name MyCloudWatchLogsRole \
  --assume-role-policy-document file://trust-policy.json
