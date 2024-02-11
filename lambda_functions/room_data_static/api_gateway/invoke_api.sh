source api_config.sh

region="us-west-2"

# Output the invoke URL
#curl -X POST https://$apiId.execute-api.$region.amazonaws.com/prod/roomdata \
#     -H "Content-Type: application/json" \
#     -H "x-api-key: YOUR_API_KEY"
#     -d @payload.json
curl -X POST https://amo000fz8f.execute-api.us-west-2.amazonaws.com/blue/roomdata \
     -H "Content-Type: application/json" \
     -d @payload.json
