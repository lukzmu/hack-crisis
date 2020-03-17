//
//  InfoViewModel.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 17/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import Foundation
import Combine

class InfoViewModel : ObservableObject {
    var didChange = PassthroughSubject<InfoViewModel, Never>()
    
    init() {
        buttonData = DataServices.getInformationLinks()
    }
    
    var buttonData : Dictionary<String, String> {
        didSet {
            didChange.send(self)
        }
    }
    
    func navigateToWebsite(link: String) {
        DeviceServices.navigateToWebsite(link: link)
    }
}
