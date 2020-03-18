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
    
    var resourceAmounts : [String] {
        return ResourceAmount.allValues.map{ $0.rawValue }
    }
    
    @Published var waterSelection : Int = 0
    @Published var foodSelection : Int = 0
    @Published var medsSelection : Int = 0
    @Published var isConv : Bool = false
    @Published var numberOfPeople : Int = 1
    @Published var description = ""
    @Published var showRequestSheet = false
    @Published var showRequestSuccess = false
    @Published var showRequestFailure = false
    
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
            latitude: Float(latitude),
            longitude: Float(longitude),
            numberOfPeople: numberOfPeople,
            description: description
        )
        
        // TODO: Do actual request to server
        
        showRequestSuccess = true
    }
}
