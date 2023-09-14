//
//  CircleButtonView.swift
//  Krypton
//
//  Created by Marco Margarucci on 08/09/23.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    let width: CGFloat
    let height: CGFloat
    let shadowOpacity: CGFloat
    
    var body: some View {
        Image(systemName: iconName)
            .font(.bodySemiBold)
            .foregroundColor(Color.theme.accent)
            .frame(width: width, height: height)
            .background(Circle().foregroundColor(Color.theme.background))
            .shadow(color: Color.theme.accent.opacity(shadowOpacity), radius: 5, x: 0, y: 0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(iconName: "info", width: 45, height: 45, shadowOpacity: 0.1)
                .padding()
                .previewLayout(.sizeThatFits)
            
            CircleButtonView(iconName: "info", width: 45, height: 45, shadowOpacity: 0.1)
                .padding()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
