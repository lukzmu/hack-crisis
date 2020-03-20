//
//  LoadingDataView.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 20/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import SwiftUI

struct LoadingDataView: View {
    @State private var angle: Double = 0.0
    @State private var isAnimating = false
    var titleText : String!
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        VStack{
            Circle()
                .trim(from: 0.2, to: 1)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [Color("greenLight"), Color("greenDark")]),
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading),
                        style: StrokeStyle(lineWidth: 5, lineCap: .round
                    )
                )
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: self.isAnimating ? 360.0 : 0.0))
                .animation(self.foreverAnimation)
                .onAppear {
                    self.isAnimating = true
                }
                .padding(.bottom)
            
            Text(titleText)
                .font(.title)
                .foregroundColor(Color("greenDark"))
            Text("please wait")
                .foregroundColor(Color("greenLight"))
        }
    }
}

struct LoadingDataView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingDataView(titleText: "Preview")
    }
}
