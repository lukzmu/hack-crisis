//
//  ConnectionStrings.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 20/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import Foundation

struct ConnectionStrings {
    static let getUserRequestString = "https://myqof4xeba.execute-api.eu-west-1.amazonaws.com/getHelpRequest"
    static let getHelpRequestsString = "https://ctiif1xdn9.execute-api.eu-west-1.amazonaws.com/default/getAllHelpRequests"
    static let createHelpRequestString = "https://wxzk3i9otl.execute-api.eu-west-1.amazonaws.com/default/newHelpRequest"
    static let removeHelpRequestString = "https://p8unq6l7bh.execute-api.eu-west-1.amazonaws.com/default/deleteHelpRequest"
}
