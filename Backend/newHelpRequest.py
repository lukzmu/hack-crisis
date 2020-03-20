import json
import boto3
from decimal import Decimal

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('HelpRequest')

deviceId  = ''
water  = ''
food  = ''
numberOfPeople = ''
meds = ''
latitude = ''
longitude = ''
isConv = ''
description = ''

def lambda_handler(event, context):
    print(event)
    body = json.loads(event['body'], parse_float=Decimal)
    
    for key in body:
        if body[key] == "":
            body[key] = None
    
    deviceId  = body['deviceId']
    water = body['water']
    food = body['food']
    numberOfPeople = body['numberOfPeople']
    meds = body['meds']
    latitude = body['latitude']
    longitude = body['longitude']
    isConv = body['isConv']
    description = body['description']

    response = table.put_item(
        Item={
            'deviceId': deviceId,
            'water': water,
            'food': food,
            'numberOfPeople': numberOfPeople,
            'meds': meds,
            'latitude': latitude,
            'longitude': longitude,
            'isConv': isConv,
            'description': description
            }
    )
    
    response = table.get_item(
        Key={
            'deviceId': str(deviceId),
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