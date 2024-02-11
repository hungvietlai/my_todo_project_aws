import boto3
import json
import sys

def get_secret(secret_id):
    try:
        client = boto3.client('secretsmanager', region_name='us-east-1')
        response = client.get_secret_value(SecretId=secret_id)
        secret_string = response['SecretString']
        return json.loads(secret_string)
    except Exception as e:
        print(f"Error fetching secret: {e}")
        sys.exit(1)

secrets = get_secret('todo_app_mysql')
with open('/etc/secrets/db_credentials.json', 'w') as f:
   json.dump(secrets, f)      
