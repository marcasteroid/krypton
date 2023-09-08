//
//  HomeView.swift
//  Krypton
//
//  Created by Marco Margarucci on 08/09/23.
//

import SwiftUI

struct HomeView: View {
    // MARK: Properties
    @State private var showPortfolio: Bool = false
    
    
    var body: some View {
        ZStack {
            // Background layer
            Color.theme.backGround
                .ignoresSafeArea()
            // Content layer
            VStack {
                HStack {
                    CircleButtonView(iconName: showPortfolio ? CircleButtonConstants.plusButtonImageName : CircleButtonConstants.infoButtonImageName)
                        .animation(nil, value: UUID())
                    Spacer()
                    Text(showPortfolio ? HomeViewConstants.portfolioHeaderTitle : HomeViewConstants.livePricesHeaderTitle)
                        .font(Font.pageTitle)
                        .foregroundColor(Color.theme.accent)
                    Spacer()
                    CircleButtonView(iconName: CircleButtonConstants.rightArrowImageName)
                        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                showPortfolio.toggle()
                            }
                        }
                }
                .padding(.horizontal)
                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .toolbar(.hidden)
        }
    }
}
