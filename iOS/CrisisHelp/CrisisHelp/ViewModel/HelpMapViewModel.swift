//
//  HelpMapViewModel.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 19/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import Foundation
import Combine

class HelpMapViewModel : ObservableObject {
    var didChange = PassthroughSubject<HelpMapViewModel, Never>()
    
    @Published var rangeSliderValue : Double = 80
    @Published var showSelectedRequest : Bool = false
    
    var helpRequests : [HelpRequest]? {
        didSet {
            didChange.send(self)
        }
    }
    
    var selectedRequest : HelpRequest? {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        // Didn't have time during hackathon to fix no location on view start
        refreshData(latitude: 0, longitude: 0)
    }
    
    func refreshData(latitude: Double, longitude: Double) {
        DataServices.getHelpRequests(
            latitude: latitude,
            longitude: longitude,
            radius: rangeSliderValue,
            completion: { result in
                self.helpRequests = result
            }
        )
    }
}
