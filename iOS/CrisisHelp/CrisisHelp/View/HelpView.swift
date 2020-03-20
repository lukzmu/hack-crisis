//
//  HelpView.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 17/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import SwiftUI

struct HelpView: View {
    @ObservedObject private var model = HelpViewModel()
    @ObservedObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Supplies")) {
                    Picker(selection: $model.waterSelection, label: HStack{
                        Image("pinWater")
                        Text("Water")
                        .foregroundColor(Color("waterColor"))
                    }, content: {
                        ForEach(0..<model.resourceAmounts.count, id: \.self) {
                            Text(self.model.resourceAmounts[$0])
                        }
                    })
                    Picker(selection: $model.foodSelection, label: HStack{
                        Image("pinFood")
                        Text("Food")
                        .foregroundColor(Color("foodColor"))
                    }, content: {
                        ForEach(0..<model.resourceAmounts.count, id: \.self) {
                            Text(self.model.resourceAmounts[$0])
                        }
                    })
                    Picker(selection: $model.medsSelection, label: HStack {
                        Image("pinMeds")
                        Text("Meds")
                        .foregroundColor(Color("medsColor"))
                    }, content: {
                        ForEach(0..<model.resourceAmounts.count, id: \.self) {
                            Text(self.model.resourceAmounts[$0])
                        }
                    })
                }
                Section(header: Text("Coronavirus")) {
                    Toggle(isOn: $model.isConv) {
                        Text("Are you infected?")
                    }
                    .accentColor(Color("medsColor"))
                }
                Section(header: Text("Additional details")) {
                    Stepper(value: self.$model.numberOfPeople, in: 1...20, label: {
                        HStack {
                            Text("People at home")
                            Spacer()
                            Text("\(self.model.numberOfPeople)")
                                .fontWeight(.bold)
                                .padding(.trailing)
                        }
                    })
                    TextField("Optional description of your problem", text: $model.description)
                }
                Section(header: Text("Are you sure you want to request help? You can check the Information page to read about ways you can help yourself.")) {
                    Button(action: {
                        self.model.showRequestSheet = true
                    }) {
                        Text("Send request")
                            .fontWeight(.bold)
                            .foregroundColor(Color("greenDark"))
                    }
                    .actionSheet(isPresented: $model.showRequestSheet) {
                        ActionSheet(
                            title: Text("Send help request"),
                            message: Text("Are you sure you want to send a help request?"),
                            buttons: [
                                .destructive(Text("Yes")) {
                                    self.model.sendHelpRequest(
                                        latitude: self.locationViewModel.userLatitude,
                                        longitude: self.locationViewModel.userLongitude
                                    )
                                },
                                .default(Text("No"))
                            ]
                        )
                    }
                }
            }
            .navigationBarTitle("Request help")
            .alert(isPresented: $model.showRequestFailure) {
                Alert(
                    title: Text("Problem"),
                    message: Text("We had a problem with sending your request. Try again."),
                    dismissButton: .default(Text("Ok"))
                )
            }
        }
        .alert(isPresented: $model.showRequestSuccess) {
            Alert(
                title: Text("Sent!"),
                message: Text("Your help request was successful."),
                dismissButton: .default(Text("Ok"))
            )
        }
        
            
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
