//
//  HelpRequestedView.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 17/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import SwiftUI

struct HelpRequestedView: View {
    @ObservedObject var model : HelpViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Divider()
                    HStack {
                        Text("Details")
                            .font(.title)
                        Spacer()
                    }
                    .padding(.bottom)
                    HStack {
                        HStack{
                            Image("pinFood")
                            Text("Food")
                                .foregroundColor(Color("foodColor"))
                        }
                        Spacer()
                        Text(model.requestedHelp?.food.rawValue ?? "")
                    }.padding(.bottom)
                    HStack {
                        HStack{
                            Image("pinWater")
                            Text("Water")
                                .foregroundColor(Color("waterColor"))
                        }
                        Spacer()
                        Text(model.requestedHelp?.water.rawValue ?? "")
                    }.padding(.bottom)
                    HStack {
                        HStack{
                            Image("pinMeds")
                            Text("Meds")
                                .foregroundColor(Color("medsColor"))
                        }
                        Spacer()
                        Text(model.requestedHelp?.meds.rawValue ?? "")
                    }.padding(.bottom)
                    HStack {
                        Text("Infected").fontWeight(.bold)
                        Spacer()
                        Text(model.requestedHelp?.isConv.string ?? "")
                    }.padding(.bottom)
                    HStack {
                        Text("People at home").fontWeight(.bold)
                        Spacer()
                        Text(String("\(model.requestedHelp?.numberOfPeople ?? 0)"))
                    }.padding(.bottom)
                    VStack {
                        HStack {
                            Text("Details").fontWeight(.bold)
                            Spacer()
                            Text(model.requestedHelp?.description ?? "")
                        }.padding(.bottom)
                    }.padding(.bottom)
                    VStack {
                        Divider()
                        Text("Are you sure you want to delete your help request?")
                            .font(.caption)
                            .padding()
                        Button(action: {
                            self.model.showRequestSheet = true
                        }) {
                            Text("Delete")
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("redLight"))
                                .foregroundColor(Color("redDark"))
                                .cornerRadius(80)
                                .padding([.leading, .trailing, .bottom])
                        }
                        .actionSheet(isPresented: $model.showRequestSheet) {
                            ActionSheet(
                                title: Text("Send help request"),
                                message: Text("Are you sure you want to send a help request?"),
                                buttons: [
                                    .destructive(Text("Yes")) {
                                        self.model.sendDeleteRequest()
                                    },
                                    .default(Text("No"))
                                ]
                            )
                        }
                    }
                }
                .padding()
                .alert(isPresented: $model.showRequestFailure) {
                    Alert(
                        title: Text("Problem"),
                        message: Text("We had a problem with sending your request. Try again."),
                        dismissButton: .default(Text("Ok"))
                    )
                }
            }
            .navigationBarTitle("My help request")
            .alert(isPresented: $model.showRequestSuccess) {
                Alert(
                    title: Text("Sent!"),
                    message: Text("Your help request was successful."),
                    dismissButton: .default(Text("Ok"))
                )
            }
        }
    }
}

struct HelpRequestedView_Previews: PreviewProvider {
    static var previews: some View {
        HelpRequestedView(model: HelpViewModel())
    }
}
