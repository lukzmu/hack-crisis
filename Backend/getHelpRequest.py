import json
import boto3
from decimal import Decimal

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('HelpRequest')
deviceId = ''

def lambda_handler(event, context):
    deviceId = event['queryStringParameters']['deviceId']
    response = table.get_item(
        Key={
            'deviceId': str(2),
        }
    )
    if 'Item' in response:
        return {
            'statusCode': 200,
            'body': json.dumps(response['Item'], default=handle_decimal_type),
        }
    return {
        'statusCode': 404,
        'body': '{"message": "HelpRequest not found."}'
    }
    
def handle_decimal_type(obj):
  if isinstance(obj, Decimal):
      if float(obj).is_integer():
         return int(obj)
      else:
         return float(obj)
  raise TypeError