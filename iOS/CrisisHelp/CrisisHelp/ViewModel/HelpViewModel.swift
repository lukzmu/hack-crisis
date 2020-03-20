//
//  HelpViewModel.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 18/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class HelpViewModel : ObservableObject {
    var didChange = PassthroughSubject<HelpViewModel, Never>()
    
    @Published var waterSelection : Int = 0
    @Published var foodSelection : Int = 0
    @Published var medsSelection : Int = 0
    @Published var isConv : Bool = false
    @Published var numberOfPeople : Int = 1
    @Published var description = ""
    @Published var showRequestSheet = false
    @Published var showRequestSuccess = false
    @Published var showRequestFailure = false
    
    var resourceAmounts : [String] {
        return ResourceAmount.allValues.map{ $0.rawValue }
    }
    @Published var viewState : String = "Loading" {
        didSet {
            didChange.send(self)
        }
    }
    var requestedHelp : HelpRequest? {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        DataServices.getUserHelpRequest(completion: { result in
            if let helpRequest = result {
                self.viewState = "HasRequest"
                self.requestedHelp = helpRequest
            } else {
                self.viewState = "NoRequest"
            }
        })
    }
    
    func sendHelpRequest(latitude: Double, longitude: Double) {
        guard latitude != 0 && longitude != 0 else {
            showRequestFailure = true
            return
        }
        viewState = "Request"
        
        let helpRequest = HelpRequest(
            deviceId: DeviceServices.getDeviceId(),
            water: ResourceAmount(rawValue: resourceAmounts[waterSelection])!,
            food: ResourceAmount(rawValue: resourceAmounts[foodSelection])!,
            meds: ResourceAmount(rawValue: resourceAmounts[medsSelection])!,
            isConv: isConv,
            latitude: latitude,
            longitude: longitude,
            numberOfPeople: numberOfPeople,
            description: description
        )
        
        DataServices.createHelpRequest(helpRequest: helpRequest, completion: { result in
            if let helpRequest = result {
                self.showRequestSuccess = true
                self.viewState = "HasRequest"
                self.requestedHelp = helpRequest
            } else {
                self.showRequestFailure = true
                self.viewState = "NoRequest"
            }
        })
    }
    
    func sendDeleteRequest() {
        if let _ = DataServices.deleteHelpRequest() {
            showRequestSuccess = true
            requestedHelp = nil
        } else {
            showRequestFailure = true
        }
    }
}
