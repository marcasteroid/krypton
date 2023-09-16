//
//  DetailView.swift
//  Krypton
//
//  Created by Marco Margarucci on 15/09/23.
//

import SwiftUI

struct DetailLoadingView: View {
    // MARK: - Properties
    @Binding var coin: Coin?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    // MARK: - Properties
    @StateObject var detailViewModel: DetailViewModel
    
    init(coin: Coin) {
        self._detailViewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        Text("")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
