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
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "greenDark")!]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "greenDark")!]
        UITableView.appearance().backgroundColor = UIColor(named: "grayBackground")
        UISwitch.appearance().onTintColor = UIColor(named: "medsColor") // For help request
    }
 
    var body: some View {
        TabView(selection: $selection){
            InfoView()
            .tabItem {
                VStack {
                    Image("barInfo")
                        .renderingMode(.template)
                    Text("Information")
                }
            }
            .tag(0)
            HelpMapView()
                .tabItem {
                    VStack {
                        Image("barMap")
                            .renderingMode(.template)
                        Text("Map")
                    }
                }
                .tag(1)
            HelpView()
            .tabItem {
                VStack {
                    Image("barHelp")
                    .renderingMode(.template)
                    Text("Help")
                }
            }
            .tag(2)
        }
        .accentColor(Color("greenDark"))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
