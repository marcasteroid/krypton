//
//  View+Extensions.swift
//  Krypton
//
//  Created by Marco Margarucci on 09/09/23.
//

import Foundation
import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var fieldText: String
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if !fieldText.isEmpty {
                    HStack {
                        Spacer()
                        Button {
                            fieldText = ""
                            UIApplication.shared.endEditing()
                        } label: {
                            Image(systemName: SearchBarConstants.searchBarClearTextImageName)
                        }
                        .foregroundColor(Color.theme.secondaryText)
                        .padding(.trailing, 4)
                    }
                }
            }
    }
}

extension View {
    func showClearButton(_ text: Binding<String>) -> some View {
        self.modifier(TextFieldClearButton(fieldText: text))
    }
}
