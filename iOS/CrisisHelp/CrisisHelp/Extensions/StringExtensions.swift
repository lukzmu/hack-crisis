//
//  StringExtensions.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 17/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import Foundation

extension String {
    var localized : String {
        return NSLocalizedString(
            self,
            bundle: Bundle.main,
            comment: ""
        )
    }
}
