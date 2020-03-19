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
}
