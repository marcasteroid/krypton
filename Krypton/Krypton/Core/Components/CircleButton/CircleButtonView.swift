//
//  CircleButtonView.swift
//  Krypton
//
//  Created by Marco Margarucci on 08/09/23.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.bodySemiBold)
            .foregroundColor(Color.theme.accent)
            .frame(width: 35, height: 35)
            .background(Circle().foregroundColor(Color.theme.backGround))
            .shadow(color: Color.theme.accent.opacity(0.1), radius: 5, x: 0, y: 0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(iconName: "info")
                .padding()
                .previewLayout(.sizeThatFits)
            
            CircleButtonView(iconName: "info")
                .padding()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
