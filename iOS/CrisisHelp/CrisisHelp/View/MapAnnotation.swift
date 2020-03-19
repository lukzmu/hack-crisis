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
    var iconAsset: String {
        if helpRequest.water == .critical || helpRequest.food == .critical || helpRequest.meds == .critical {
            return "criticalPin"
        }
        if helpRequest.water == .bad || helpRequest.food == .bad || helpRequest.meds == .bad {
            return "badPin"
        }
        return "badPin"
    }
    
    init(
        coordinate: CLLocationCoordinate2D,
        helpRequest: HelpRequest
    ) {
        self.coordinate = coordinate
        self.helpRequest = helpRequest
    }
}
