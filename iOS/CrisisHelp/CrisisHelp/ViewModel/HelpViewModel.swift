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
    var viewState : String = "Loading" {
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
        if let helpRequest = DataServices.getUserHelpRequest() {
            viewState = "HasRequest"
            requestedHelp = helpRequest
        } else {
            viewState = "NoRequest"
        }
    }
    
    func sendHelpRequest(latitude: Double, longitude: Double) {
        guard latitude != 0 && longitude != 0 else {
            showRequestFailure = true
            return
        }
        
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
        
        showRequestSuccess = true
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
