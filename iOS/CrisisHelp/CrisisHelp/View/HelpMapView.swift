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
    
    var body: some View {
        ZStack {
            MapView()
            VStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.white)
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
                            Text("\(model.rangeSliderValue.clean)km")
                                .fontWeight(.bold)
                                .padding(.trailing)
                        }
                        Slider(value: $model.rangeSliderValue, in: 10...100, step: 10)
                            .accentColor(Color.green)
                            .padding([.leading, .trailing, .bottom])
                            .foregroundColor(Color("appColor"))
                        Button(action: {
                            
                        }) {
                            Text("Apply Changes")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("appColor"))
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                                .padding([.leading, .trailing])
                                
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct HelpMapView_Previews: PreviewProvider {
    static var previews: some View {
        HelpMapView()
    }
}
