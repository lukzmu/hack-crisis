import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('HelpRequest')

def lambda_handler(event, context):
    response = table.put_item(
        Item={
            'deviceId': 'testID23',
            'water': 'Critical',
            'food': 'Critical',
            'meds': 'Critical',
            'isConv': 'True',
            'latitude': '27',
            'longitude': '72',
            'numberOfPeople': '3',
            'description': 'test2'
            }
    )