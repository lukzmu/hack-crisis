![Crisis Help](/Docs/baner.png)

![Platforms](https://img.shields.io/badge/platforms-iOS-lightgrey)
![License](https://img.shields.io/badge/license-MIT-green)
![Hackathon](https://img.shields.io/badge/hackathon-Hack_Crisis-red)

# Overview

![Information Page](/Docs/information_page.gif)
![Information Page](/Docs/send_help_request.gif)
![Information Page](/Docs/filter_requests.gif)

## About the application

**Crisis Help** is an application designed for the [Hack the Crisis: Tech for Good Hackathon](https://www.hackcrisis.com/) hosted online by [DO OK](dook.pro) with partnership from Govtech Poland, AWS, Google, Guaana and ProIdea. The code will be Open Source under the MIT license, so if you have any idea how to improve it and help more people, just do it.

**Crisis Help** tackles the problem of isolation - government is asking people to stay home, but the resources we keep in our households aren't limitless. The application allows you to share information that you are missing specific kind of mandatory products in your household and share this information with government specified institutions (for MVP purposes, this is an open list, so that anyone can help).

**Hackathon category:** Isolation

## Meet the team

- [Lukasz Zmudzinski](https://zmudzinski.me) - Team Leader, AWS Backend, iOS app
- [Jacek Bazydlo](https://www.linkedin.com/in/jacekbazydlo/) - AWS Backend
- [Karolina Sala](https://www.linkedin.com/in/karolina-sala/) - UX Design

## Youtube project presentation

- http://www.youtube.com/watch?v=APdHiiLn2qE

# Technical Details

## Help Request model

This is the core model of our application. It describes a user help request that can be seen by others to provide supplies.

| **Field** | **Type** | **Required** | **Description** |
| :-- | :-- | :-- | :-- |
| `deviceId` | `String` | Yes | The unique mobile device identifier |
| `water` | `String : [Normal, Bad, Critical]` | Yes | What is the user status of water supplies |
| `food` | `String : [Normal, Bad, Critical]` | Yes | What is the user status of food supplies |
| `meds` | `String : [Normal, Bad, Critical]` | Yes | What is the user status of meds supplies |
| `isConv` | `Bool` | Yes | Is the user diagnosed with Coronavirus |
| `latitude` | `Double` | Yes | User latitude geolocation |
| `longitude` | `Double` | Yes | User longitude geolocation |
| `description` | `String` | No | Additional description,  if the user has something to add |

## Backend documentation

![System structure](/Docs/system_structure.png)

We decided to use cloud services to increase the scalability of our application. Backend services are contacted through HTTP requests from the mobile application. The requests lands in the API Gateaway and is directed to the requested Lambda function (`Python3.7`). The function processes the request and makes changes in the NoSQL DynamoDB table containing all HelpRequests.

### Lambda endpoint details

| **Lambda function** | **Type** | **Parameters** | **Description** | **Code** |
| :-- | :-- | :-- | :-- | :-- |
| `newHelpRequest` | POST | `HelpRequest` | Creates a new HelpRequest | [Link](https://github.com/lukzmu/hackcrisis2020/blob/master/Backend/newHelpRequest.py) |
| `deleteHelpRequest` | POST | `deviceId` | Removes user HelpRequest | [Link](https://github.com/lukzmu/hackcrisis2020/blob/master/Backend/deleteHelpRequest.py) |
| `getHelpRequest` | GET | `deviceId` | Gets user help request | [Link](https://github.com/lukzmu/hackcrisis2020/blob/master/Backend/getHelpRequest.py) |
| `getAllHelpRequests` | GET | `latitude, longitude, radius` | Gets help requests at `radius` to user location | [Link](https://github.com/lukzmu/hackcrisis2020/blob/master/Backend/getAllHelpRequests.py) |

### AWS endpoint urls

- `https://wxzk3i9otl.execute-api.eu-west-1.amazonaws.com/default/newHelpRequest`
- `https://p8unq6l7bh.execute-api.eu-west-1.amazonaws.com/default/deleteHelpRequest`
- `https://myqof4xeba.execute-api.eu-west-1.amazonaws.com/getHelpRequest`
- `https://ctiif1xdn9.execute-api.eu-west-1.amazonaws.com/default/getAllHelpRequests`

## iOS documentation

- Built using Swift programming language,
- Views are built using SwiftUI,
- No unit/interface testing was performed due to limited hackathon time,
- Code can be previewed in the [iOS directory](https://github.com/lukzmu/hackcrisis2020/tree/master/iOS).

### Dependencies
Dependencies are managed by the Swift Package Manager (SPM).

| **Dependency** | **Version** | **Description** | **Dependency Page** |
| :-- | :-- | :-- | :-- |
| Alamofire | `5.0.4` | Handling external API requests | [Link](https://github.com/Alamofire/Alamofire) |
| SwiftyJSON | `5.0.0` | Processing JSON file format | [Link](https://github.com/SwiftyJSON/SwiftyJSON) |
| ObjectMapper | `3.5.2` | Mapping JSON to HelpRequest objects | [Link](https://github.com/tristanhimmelman/ObjectMapper) |

### App structure
The application implements the MVVM architecture pattern.

| **Directory** | **Description** |
| :-- | :-- |
| `Model` | Holds classes responsible for storing the data model information |
| `View` | Contains SwiftUI view building blocks |
| `ViewModel` | Contains classes responsible for View-Model communication |
| `Services` | Contains device and backend communication classes |
| `Extensions` | Contains class extensions making life easier |

# Design guidelines

All system UX design files can be previewed in the [Design directory](https://github.com/lukzmu/hackcrisis2020/tree/master/Design).

## Resource color schema

| **Color Hex** | **Resource** | 
| :-- | :-- |
| `#3E4A59` | Food | 
| `#0090D8` | Water | 
| `#F74165` | Meds | 

## Application color schema

| **Color Hex** | **Color Name** | 
| :-- | :-- |
| `#F9FBFD` | Background |
| `#47C68F` | Accent | 
| `#E3F7EE` | Accept Button Background | 
| `#F74165` | Destructive Accent | 
| `#F8E7EB` | Destructive Button Background | 

## Map icon guideline

| **Icon** | **Meaning** |
| :-- | :-- |
| ![Water](https://raw.githubusercontent.com/lukzmu/hackcrisis2020/master/iOS/CrisisHelp/CrisisHelp/Assets.xcassets/pinWater.imageset/pinWater_1x.png) | Prioritize water for this user |
| ![Food](https://raw.githubusercontent.com/lukzmu/hackcrisis2020/master/iOS/CrisisHelp/CrisisHelp/Assets.xcassets/pinFood.imageset/pinFood_1x.png) | Prioritize food for this user |
| ![Meds](https://raw.githubusercontent.com/lukzmu/hackcrisis2020/master/iOS/CrisisHelp/CrisisHelp/Assets.xcassets/pinMeds.imageset/pinMeds_1x.png) | Prioritize meds for this user |
| ![Water and food](https://raw.githubusercontent.com/lukzmu/hackcrisis2020/master/iOS/CrisisHelp/CrisisHelp/Assets.xcassets/pinWaterFood.imageset/pinWaterFood_1x.png) | Prioritize food and water for this user |
| ![Food and meds](https://raw.githubusercontent.com/lukzmu/hackcrisis2020/master/iOS/CrisisHelp/CrisisHelp/Assets.xcassets/pinFoodMeds.imageset/pinFoodMeds_1x.png) | Prioritize food and meds for this user |
| ![Meds and water](https://raw.githubusercontent.com/lukzmu/hackcrisis2020/master/iOS/CrisisHelp/CrisisHelp/Assets.xcassets/pinWaterMeds.imageset/pinWaterMeds_1x.png) | Prioritize water and meds for this user |
| ![Needs all](https://raw.githubusercontent.com/lukzmu/hackcrisis2020/master/iOS/CrisisHelp/CrisisHelp/Assets.xcassets/pinAll.imageset/pinAll_1x.png) | This user needs all resources |
