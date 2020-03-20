import json
import boto3
import math
from decimal import Decimal

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('HelpRequest')
userLat = ''
userLon = ''
radius = ''

def lambda_handler(event, context):
    userLat = float(event['queryStringParameters']['userLat'])
    userLon = float(event['queryStringParameters']['userLon'])
    radius = float(event['queryStringParameters']['radius']) * 1000
    response = table.scan()

    if 'Items' in response:
        if userLat == 0 and userLon == 0:
            return {
                'statusCode': 200,
                'body': json.dumps(response['Items'], default=handle_decimal_type)
            }

        filtered_items = []
        user_location = float(userLat), float(userLon)
        for item in response['Items']:
            item_location = float(item['latitude']), float(item['longitude'])
            distance = haversine(user_location, item_location)
            if distance <= radius:
                filtered_items.append(item)
        return {
            'statusCode': 200,
            'body': json.dumps(filtered_items, default=handle_decimal_type)
        }

    return {
        'statusCode': 404,
        'body': '{"message":"No HelpRequests found."}'
    }

def haversine(coord1, coord2):
    R = 6372800  # Earth radius in meters
    lat1, lon1 = coord1
    lat2, lon2 = coord2
    
    phi1, phi2 = math.radians(lat1), math.radians(lat2) 
    dphi       = math.radians(lat2 - lat1)
    dlambda    = math.radians(lon2 - lon1)
    a = math.sin(dphi/2)**2 + math.cos(phi1)*math.cos(phi2)*math.sin(dlambda/2)**2
    
    return 2*R*math.atan2(math.sqrt(a), math.sqrt(1 - a))
    
def handle_decimal_type(obj):
  if isinstance(obj, Decimal):
      if float(obj).is_integer():
         return int(obj)
      else:
         return float(obj)
  raise TypeError