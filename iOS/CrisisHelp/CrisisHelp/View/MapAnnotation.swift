//
//  MapAnnotation.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 19/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import Foundation
import MapKit
import SwiftUI

class MapAnnotation : NSObject, MKAnnotation {
    var coordinate : CLLocationCoordinate2D
    var helpRequest : HelpRequest
    
    var title: String? {
        return "💧: \(helpRequest.water!.textIcon) | 🍔: \(helpRequest.food!.textIcon) | 💊: \(helpRequest.meds!.textIcon)"
    }
    var subtitle: String? {
        return helpRequest.description ?? ""
    }
    var iconAsset: UIImage {
        let isWater = helpRequest.water != ResourceAmount.normal
        let isFood = helpRequest.food != ResourceAmount.normal
        let isMeds = helpRequest.meds != ResourceAmount.normal
        
        if isWater && isFood && isMeds {
            return UIImage(named: "pinAll")!
        }
        if isWater && isFood {
            return UIImage(named: "pinWaterFood")!
        }
        if isWater && isMeds {
            return UIImage(named: "pinWaterMeds")!
        }
        if isFood && isMeds {
            return UIImage(named: "pinFoodMeds")!
        }
        if isWater {
            return UIImage(named: "pinWater")!
        }
        if isFood {
            return UIImage(named: "pinFood")!
        }
        if isMeds {
            return UIImage(named: "pinMeds")!
        }
        return UIImage(named: "pinAll")!
    }
    
    init(
        coordinate: CLLocationCoordinate2D,
        helpRequest: HelpRequest
    ) {
        self.coordinate = coordinate
        self.helpRequest = helpRequest
    }
}
