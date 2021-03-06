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
import Alamofire
import ObjectMapper

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
    
    static func getUserHelpRequest(completion: @escaping (HelpRequest?) -> Void) {
        let deviceId = DeviceServices.getDeviceId()
        let parameters : Parameters = ["deviceId": deviceId]
        AF.request(
            ConnectionStrings.getUserRequestString,
            parameters: parameters
        ).responseString { response in
            if let status = response.response?.statusCode {
                if status == 200 {
                    if let json = response.value {
                        completion(HelpRequest(JSONString: json))
                        return
                    }
                }
            }
            completion(nil)
        }
    }
    
    static func getHelpRequests(
        latitude: Double?,
        longitude: Double?,
        radius: Double,
        completion: @escaping ([HelpRequest]?) -> Void
    ) {
        let parameters = [
            "userLat" : latitude,
            "userLon" : longitude,
            "radius" : radius
        ]
        
        AF.request(
            ConnectionStrings.getHelpRequestsString,
            parameters: parameters
        ).responseJSON { response in
            if let data = response.data {
                let json = JSON(data)
                var helpRequests = [HelpRequest]()
                for (_, jsonObject) in json {
                    let jsonString = jsonObject.rawString()!
                    if let helpRequest = HelpRequest(JSONString: jsonString) {
                        helpRequests.append(helpRequest)
                    }
                }
                completion(helpRequests)
                return
            }
            completion(nil)
        }
    }
    
    static func createHelpRequest(helpRequest: HelpRequest, completion: @escaping (HelpRequest?) -> Void) {
        let json = helpRequest.toJSON()
        AF.request(
            ConnectionStrings.createHelpRequestString,
            method: .post,
            parameters: json,
            encoding: JSONEncoding.default
        ).responseString { response in
            if let status = response.response?.statusCode {
                if status == 200 {
                    if let json = response.value {
                        completion(HelpRequest(JSONString: json))
                        return
                    }
                }
            }
            completion(nil)
        }
    }
    
    static func deleteHelpRequest(completion: @escaping (Bool) -> Void) {
        let deviceId = DeviceServices.getDeviceId()
        AF.request(
            ConnectionStrings.removeHelpRequestString,
            method: .post,
            parameters: ["deviceId": deviceId],
            encoding: JSONEncoding.default
        ).response { response in
            if let status = response.response?.statusCode {
                if status == 204 {
                    completion(true)
                    return
                }
            }
            completion(false)
        }
    }
}
