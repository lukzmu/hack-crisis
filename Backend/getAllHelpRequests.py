import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('HelpRequest')

def lambda_handler(event, context):
    response = table.scan()
    print(response)
    return {
        'statusCode': 200,
        'body': response
    }