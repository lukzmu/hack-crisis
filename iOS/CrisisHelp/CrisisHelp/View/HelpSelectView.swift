//
//  HelpSelectView.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 20/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import SwiftUI

struct HelpSelectView: View {
    @ObservedObject private var model = HelpViewModel()
    
    var body: some View {
        VStack{
            containedView()
        }
    }
    
    func containedView() -> AnyView {
        switch model.viewState {
        case "NoRequest": return AnyView(HelpRequestView(model: model))
        case "HasRequest": return AnyView(HelpRequestedView(model: model))
        case "Request": return AnyView(LoadingDataView(titleText: "Contacting Server"))
        default: return AnyView(LoadingDataView(titleText: "Loading"))
        }
    }
}

struct HelpSelectView_Previews: PreviewProvider {
    static var previews: some View {
        HelpSelectView()
    }
}
