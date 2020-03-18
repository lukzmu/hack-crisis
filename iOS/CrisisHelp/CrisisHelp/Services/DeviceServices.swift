//
//  DeviceServices.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 17/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import Foundation
import SwiftUI

struct DeviceServices {
    static func navigateToWebsite(link : String) {
        if let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
    }
    
    static func getDeviceId() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
}
