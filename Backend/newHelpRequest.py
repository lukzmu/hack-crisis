import json
import boto3

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
    deviceId  = event['queryStringParameters']['deviceId']
    water = event['queryStringParameters']['water']
    food = event['queryStringParameters']['food']
    numberOfPeople = event['queryStringParameters']['numberOfPeople']
    meds = event['queryStringParameters']['meds']
    latitude = event['queryStringParameters']['latitude']
    longitude = event['queryStringParameters']['longitude']
    isConv = event['queryStringParameters']['isConv']
    description = event['queryStringParameters']['description']

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