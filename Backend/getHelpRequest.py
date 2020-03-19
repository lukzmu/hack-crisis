import json
import boto3
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('HelpRequest')
deviceId = ''
def lambda_handler(event, context):
    print(event)
    deviceId = event['queryStringParameters']['deviceId']
    try:   
        response = table.get_item(
            Key={
                'deviceId': deviceId
                }
        )
        return {
            'statusCode': 200,
            'body': json.dumps(response['Item']),
        }
    except:
        return {
            'statusCode': 404,
            'body': '{"message": "Not found."}'
        }