//
//  HackathonViewModel.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 17/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import Foundation
import Combine

class HackathonViewModel : ObservableObject {
    var didChange = PassthroughSubject<HackathonViewModel, Never>()
    
    func navigateToRepository() {
        let link = "https://gitlab.com/lukzmu/hackcrisis2020"
        DeviceServices.navigateToWebsite(link: link)
    }
    
    func navigateToHackathon() {
        let link = "https://www.hackcrisis.com/"
        DeviceServices.navigateToWebsite(link: link)
    }
}
