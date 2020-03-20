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
    
    static func getUserHelpRequest() -> HelpRequest? {
        // Todo: Actual API call
        return nil
    }
    
    static func getHelpRequests(inRadius: Double) -> [HelpRequest] {
        // Todo: Actual API call
        return []
    }
    
    static func deleteHelpRequest() -> HelpRequest? {
        // Todo: Actual API call
        return nil
    }
}
