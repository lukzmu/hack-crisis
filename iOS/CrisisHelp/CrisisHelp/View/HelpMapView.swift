//
//  HelpMapView.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 19/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import SwiftUI

struct HelpMapView: View {
    @ObservedObject var model = HelpMapViewModel()
    @ObservedObject var locationModel = LocationViewModel()
    @Environment(\.colorScheme) var mode
    
    var body: some View {
        ZStack {
            MapView(
                model: model,
                locationModel: locationModel,
                helpRequests: model.helpRequests
            ).onAppear {
                self.model.refreshData(
                    latitude: self.locationModel.userLatitude,
                    longitude: self.locationModel.userLongitude
                )
            }
            if !model.showSelectedRequest {
                VStack {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(mode == .dark ? Color.black : Color.white)
                            .frame(height: 200)
                            .padding([.leading, .trailing])
                        VStack {
                            HStack {
                                Text("Find location")
                                    .font(.title)
                                    .padding(.leading)
                                Spacer()
                            }
                            HStack{
                                Text("Range")
                                    .foregroundColor(.gray)
                                    .padding(.leading)
                                Spacer()
                                HStack{
                                    Text("\(model.rangeSliderValue.clean)")
                                    .fontWeight(.bold)
                                    Text("km")
                                    .fontWeight(.bold)
                                }
                                .padding(.trailing)
                            }
                            Slider(value: $model.rangeSliderValue, in: 10...100, step: 10)
                                .accentColor(Color.green)
                                .padding([.leading, .trailing, .bottom])
                                .foregroundColor(Color("appColor"))
                            Button(action: {
                                self.model.refreshData(
                                    latitude: self.locationModel.userLatitude,
                                    longitude: self.locationModel.userLongitude
                                )
                            }) {
                                Text("Apply Changes")
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color("greenLight"))
                                    .foregroundColor(Color("greenDark"))
                                    .cornerRadius(80)
                                    .padding([.leading, .trailing])
                            }
                        }
                        .padding()
                    }
                }.animation(.easeIn)
            }
            // This will be ugly af, but it's like that due to hackathon time limit
            if model.showSelectedRequest {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.white)
                    .frame(height: 280)
                    .padding([.leading, .trailing])
                    VStack {
                        HStack {
                            Text("Help request details")
                            .font(.title)
                            Spacer()
                        }.padding()
                        HStack {
                            Text("Food: \(model.selectedRequest?.food.rawValue ?? "")")
                            Spacer()
                        }.padding([.leading, .trailing])
                        HStack {
                            Text("Water: \(model.selectedRequest?.water.rawValue ?? "")")
                            Spacer()
                        }.padding([.leading, .trailing])
                        HStack {
                            Text("Medicines: \(model.selectedRequest?.meds.rawValue ?? "")")
                            Spacer()
                        }.padding([.leading, .trailing])
                        HStack {
                            Text("Infected: \(model.selectedRequest?.isConv.string ?? "")")
                            Spacer()
                        }.padding([.leading, .trailing])
                        HStack {
                            Text("People at home: \(String(model.selectedRequest?.numberOfPeople ?? 1))")
                            Spacer()
                        }.padding([.leading, .trailing])
                        HStack {
                            Text("Details: \(String(model.selectedRequest?.description ?? ""))")
                            Spacer()
                        }.padding([.leading, .trailing])
                        Button(action: {
                            self.model.showSelectedRequest = false
                        }) {
                            Text("Close")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("greenLight"))
                                .foregroundColor(Color("greenDark"))
                                .cornerRadius(10)
                                .padding()
                        }
                        
                    }.padding([.leading, .trailing])
                }
                .animation(.easeIn)
            }
        }
    }
}

struct HelpMapView_Previews: PreviewProvider {
    static var previews: some View {
        HelpMapView()
    }
}
