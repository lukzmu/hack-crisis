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
                    VStack() {
                        Divider()
                        HStack {
                            Text("Keep yourself safe!")
                            .fontWeight(.bold)
                            Spacer()
                        }
                        .padding()
                        Text("Coronavirus disease (COVID-19) is a new strain that was discovered in December 2019 and has not been previously identified in humans.")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding()
                        Text("Common signs of infection include respiratory symptoms, fever, cough, shortness of breath and breathing difficulties. In more severe cases, infection can cause pneumonia, severe acute respiratory syndrome, kidney failure and even death.")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding()
                        Text("Standard recommendations to prevent infection spread include regular hand washing, covering mouth and nose when coughing and sneezing, thoroughly cooking meat and eggs. Avoid close contact with anyone showing symptoms of respiratory illness such as coughing and sneezing.")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    VStack {
                        Divider()
                        HStack {
                            Text("Check for more information")
                            .fontWeight(.bold)
                            Spacer()
                        }
                        .padding()
                        
                        ForEach([String](model.buttonData.keys), id: \.self) { key in
                            Button(action: {
                                self.model.navigateToWebsite(link: self.model.buttonData[key]!)
                            }) {
                                Text(key)
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color("greenLight"))
                                    .foregroundColor(Color("greenDark"))
                                    .cornerRadius(80)
                                    .padding([.leading, .trailing, .bottom])
                            }
                        }
                    }
                    .navigationBarTitle("Information")
                    .navigationBarItems(trailing:
                        NavigationLink(destination: HackathonView()) {
                            Image(systemName: "heart.fill")
                            .foregroundColor(Color("greenDark"))
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
