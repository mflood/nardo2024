import json
import redis
import sys

def lambda_handler(event, context):

    print("Stdout")
    sys.stdout.write("sys.stdout")
    sys.stderr.write("sys.stderr")

    # Load data from the JSON file
    with open('backup.json', 'r') as file:
        data = json.load(file)

    # Connect to Redis
    #redis_client = redis.StrictRedis(host='nar-my-1lbhi0osq14ro.rtzcza.0001.usw2.cache.amazonaws.com', port=6379, db=0)

    # Load data into Redis
    #for item in data:
    #    redis_key = item['redis_key']
    #    redis_value = json.dumps(item['redis_value_object'])
    #    redis_client.set(redis_key, redis_value)

    return {
        'statusCode': 200,
        'body': json.dumps('Data loaded into Redis successfully')
    }


if __name__ == "__main__":
    lambda_handler({}, {})
