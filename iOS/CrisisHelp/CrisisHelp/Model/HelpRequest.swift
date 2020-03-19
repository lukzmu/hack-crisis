//
//  HelpRequest.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 17/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import Foundation
import SwiftUI
import ObjectMapper

enum ResourceAmount : String {
    case critical = "Critical"
    case bad = "Bad"
    case normal = "Normal"
    
    var color : Color {
        switch self {
        case .critical: return Color.red
        case .bad: return Color.orange
        case .normal: return Color.green
        }
    }
    
    var textIcon : String {
        switch self {
        case .critical: return "🔴"
        case .bad: return "🟠"
        case .normal: return "🟢"
        }
    }
    
    static let allValues = [
        normal, bad, critical
    ]
}

class HelpRequest : Mappable {
    var deviceId : String!
    var water : ResourceAmount!
    var food : ResourceAmount!
    var meds : ResourceAmount!
    var isConv : Bool!
    var latitude : Double!
    var longitude : Double!
    var numberOfPeople : Int!
    var description : String?
    
    init(
        deviceId : String,
        water : ResourceAmount,
        food : ResourceAmount,
        meds : ResourceAmount,
        isConv : Bool,
        latitude : Double,
        longitude : Double,
        numberOfPeople : Int,
        description : String
    ) {
        self.deviceId = deviceId
        self.water = water
        self.food = food
        self.meds = meds
        self.isConv = isConv
        self.latitude = latitude
        self.longitude = longitude
        self.numberOfPeople = numberOfPeople
        self.description = description
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        deviceId <- map["deviceId"]
        water <- map["water"]
        food <- map["food"]
        meds <- map["meds"]
        isConv <- map["isConv"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        numberOfPeople <- map["numberOfPeople"]
        description <- map["description"]
    }
}
