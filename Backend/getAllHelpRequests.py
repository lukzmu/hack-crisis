import json
import boto3
from decimal import Decimal

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('HelpRequest')

def lambda_handler(event, context):
    response = table.scan()
    print(response)
    return {
        'statusCode': 200,
        'body': json.dumps(response['Items'], default=handle_decimal_type)
    }
    
def handle_decimal_type(obj):
  if isinstance(obj, Decimal):
      if float(obj).is_integer():
         return int(obj)
      else:
         return float(obj)
  raise TypeError