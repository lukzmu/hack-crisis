import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('HelpRequest')

def lambda_handler(event, context):
    print(event)
    body = json.loads(event['body'])
    deviceId  = body['deviceId']
    
    response = table.delete_item(
        Key={
            'deviceId': deviceId
        }
    )
    
    return {
        'statusCode': 204,
    }