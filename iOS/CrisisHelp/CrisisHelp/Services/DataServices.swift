//
//  DataServices.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 17/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftyJSON

struct DataServices {
    static func getInformationLinks() -> Dictionary<String, String> {
        guard let data = NSDataAsset(name: "websitedata")?.data else {
            return Dictionary<String, String>()
        }
        
        do {
            var result = Dictionary<String, String>()
            for (_, siteData) in try JSON(data: data) {
                result[siteData["websiteName"].rawString()!] = siteData["websiteUrl"].rawString()!
            }
            return result
        } catch let error {
            print(error.localizedDescription)
            return Dictionary<String, String>()
        }
    }
    
    static func getHelpRequests(inRadius: Double) -> [HelpRequest] {
        // Todo: Actual API call
        return [
            HelpRequest(
                deviceId: "abc123",
                water: .bad,
                food: .normal,
                meds: .critical,
                isConv: false,
                latitude: 53.773088,
                longitude: 20.478222,
                numberOfPeople: 3,
                description: "Ryszarda Knosały 9"
            ),
            HelpRequest(
                deviceId: "abc123",
                water: .normal,
                food: .normal,
                meds: .bad,
                isConv: false,
                latitude: 53.855388,
                longitude: 20.958299,
                numberOfPeople: 3,
                description: "Krótka 2"
            ),
        ]
    }
}
