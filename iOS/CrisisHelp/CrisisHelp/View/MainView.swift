//
//  ContentView.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 17/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            HelpView()
                .tabItem {
                    VStack {
                        Image(systemName: "exclamationmark.bubble")
                        Text("Help".localized)
                    }
                }
                .tag(0)
            MapView()
                .tabItem {
                    VStack {
                        Image(systemName: "map")
                        Text("Map".localized)
                    }
                }
                .tag(1)
            InfoView()
                .tabItem {
                    VStack {
                        Image(systemName: "info")
                        Text("Information".localized)
                    }
                }
                .tag(2)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
