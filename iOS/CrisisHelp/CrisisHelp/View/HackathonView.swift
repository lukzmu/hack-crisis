//
//  HackathonView.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 17/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import SwiftUI

struct HackathonView: View {
    @ObservedObject var model = HackathonViewModel()
    
    var body: some View {
        NavigationView() {
            VStack {
                Text("Project related links")
                    .fontWeight(.bold)
                    .padding()
                Button(action: {
                    self.model.navigateToHackathon()
                }) {
                    Text("Hack the Crisis website").padding()
                }
                Button(action: {
                    self.model.navigateToRepository()
                }) {
                    Text("Project repository").padding()
                }
                Spacer()
                Text("From Poland with ♥️.").padding()
            }
        }
    }
}

struct HackathonView_Previews: PreviewProvider {
    static var previews: some View {
        HackathonView()
    }
}
