//
//  HomeView.swift
//  Krypton
//
//  Created by Marco Margarucci on 08/09/23.
//

import SwiftUI

struct HomeView: View {
    // MARK: Properties
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var noCoinsFound: Bool = false
    
    var body: some View {
        ZStack {
            // Background layer
            Color.theme.backGround
                .ignoresSafeArea()
            // Content layer
            VStack {
                homeHeader
                SearchBarView(searchText: $homeViewModel.searchText)
                columnHeader
                if !showPortfolio {
                    if !homeViewModel.allCoins.isEmpty {
                        allCoinsList
                            .transition(.move(edge: .leading))
                    } else {
                        VStack {
                            Spacer()
                            Text("Nothing found...")
                                .font(Font.infoLarge)
                                .foregroundColor(Color.theme.secondaryText)
                            Image("crying")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Spacer()
                        }
                    }
                }
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
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
        .environmentObject(dev.homeViewModel)
    }
}

// MARK: - Extensions

extension HomeView {
    // Home header
    private var homeHeader: some View {
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
                    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
                    impactFeedbackGenerator.impactOccurred()
                }
        }
        .padding(.horizontal)
    }
    
    // All coins list
    private var allCoinsList: some View {
        List {
            ForEach(homeViewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumns: false)
                    .listRowInsets(.init(top: 10, leading: 6, bottom: 10, trailing: 14))
            }
        }
        .scrollIndicators(.hidden)
        .listStyle(.plain)
    }
    
    // Portfolio coins list
    private var portfolioCoinsList: some View {
        List {
            ForEach(homeViewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumns: true)
                    .listRowInsets(.init(top: 10, leading: 6, bottom: 10, trailing: 14))
            }
        }
        .scrollIndicators(.hidden)
        .listStyle(.plain)
    }
    
    // Column header
    private var columnHeader: some View {
        HStack {
            Text(HomeViewConstants.listCoinHeader)
            Spacer()
            if showPortfolio { Text(HomeViewConstants.listHoldingsHeader) }
            Text(HomeViewConstants.listPriceHeader)
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(Font.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
