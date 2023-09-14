//
//  SearchBarView.swift
//  Krypton
//
//  Created by Marco Margarucci on 09/09/23.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: SearchBarConstants.searchBarLeadingImageName)
                .foregroundColor(Color.theme.secondaryText.opacity(0.5))
            TextField(SearchBarConstants.searchBarPlaceholder, text: $searchText)
                .foregroundColor(Color.theme.accent)
                .focused($isTextFieldFocused)
                .showClearButton($searchText)
                .autocorrectionDisabled()
        }
        .font(.textField)
        .padding()
        .background(RoundedRectangle(cornerRadius: 25)
                    .fill(Color.theme.background)
                    .shadow(color: Color.theme.accent.opacity(0.1), radius: 5, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
