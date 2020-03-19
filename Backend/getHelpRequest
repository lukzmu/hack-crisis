import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('HelpRequest')

def lambda_handler(event, context):
    response = table.get_item(
        Key={
            'deviceId': 'testID2'
            }
    )
    
    print(response)
    return {
        'statusCode': 200,
        'body': response
    }