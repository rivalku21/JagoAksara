//
//  ChartBar.swift
//  skripsi
//
//  Created by Rival Fauzi on 03/01/24.
//

import SwiftUI

struct ProgressBar: View {
    var value: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: getWidth(geometry.size.width, 0.02), height: geometry.size.height * 0.6)
                    .foregroundColor(Color.color4FA9E0)
                    .animation(.linear(duration: 0.1))
                    .padding(.horizontal, geometry.size.width * 0.01)
                
                VStack {
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: getWidth(geometry.size.width, 0.06), height: geometry.size.height * 0.2)
                        .foregroundColor(Color.colorB9E1F9)
                        .animation(.linear(duration: 0.1))
                        .padding(.horizontal, geometry.size.width * 0.03)
                        .padding(.top, geometry.size.height * 0.3)
                    Spacer()
                }
            }
        }
    }
    
    private func getWidth(_ width: Double, _ point: Double) -> Double {
        let minimumValue = min((CGFloat(self.value) * width) - (width * point), width)
        
        if minimumValue < 0 {
            return 0
        }
            
        return minimumValue
    }
}
