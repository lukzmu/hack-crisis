//
//  InfoView.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 17/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    @ObservedObject var model = InfoViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Coronavirus disease (COVID-19) is a new strain that was discovered in 2019. Common signs of infection include respiratory symptoms, fever, cough, shortness of breath and breathing difficulties. In more severe cases, infection can cause pneumonia, severe acute respiratory syndrome, kidney failure and even death.")
                            .multilineTextAlignment(.center)
                            .padding()
                        
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.1))
                            .frame(height: 70)
                            .padding([.leading, .trailing])
                        HStack(alignment: .center) {
                            Text("😮").font(.title).padding(.trailing)
                            Text("Don't panic!").font(.title)
                        }
                    }
                    VStack {
                        Text("Places to check for information:")
                        .fontWeight(.bold)
                        .padding()
                        
                        ForEach([String](model.buttonData.keys), id: \.self) { key in
                            Button(action: {
                                self.model.navigateToWebsite(link: self.model.buttonData[key]!)
                            }) {
                                Text(key).padding()
                            }
                        }
                    }
                    .navigationBarTitle("Keep yourself safe!")
                    .navigationBarItems(trailing:
                        NavigationLink(destination: HackathonView()) {
                            Image(systemName: "heart.fill")
                        }
                    )
                }
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
