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
                        Text("Help")
                    }
                }
                .tag(1)
            MapView()
                .tabItem {
                    VStack {
                        Image(systemName: "map")
                        Text("Map")
                    }
                }
                .tag(2)
            InfoView()
                .tabItem {
                    VStack {
                        Image(systemName: "info")
                        Text("Information")
                    }
                }
                .tag(0)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
