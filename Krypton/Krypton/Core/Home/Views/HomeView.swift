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
    @State private var showPortfolioView: Bool = false
    @State private var noCoinsFound: Bool = false
    
    var body: some View {
        ZStack {
            // Background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(homeViewModel)
                })
            // Content layer
            VStack {
                homeHeader
                HomeStatisticView(showPortfolio: $showPortfolio)
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
                                .font(.infoLarge)
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
            CircleButtonView(iconName: showPortfolio ? CircleButtonConstants.plusButtonImageName : CircleButtonConstants.infoButtonImageName, width: 45, height: 45, shadowOpacity: 0.1)
                .animation(nil, value: UUID())
                .onTapGesture {
                    showPortfolioView.toggle()
                }
            Spacer()
            Text(showPortfolio ? HomeViewConstants.portfolioHeaderTitle : HomeViewConstants.livePricesHeaderTitle)
                .font(.pageTitle)
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: CircleButtonConstants.rightArrowImageName, width: 45, height: 45, shadowOpacity: 0.1)
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
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
