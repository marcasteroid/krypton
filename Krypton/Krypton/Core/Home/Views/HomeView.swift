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
    @State private var selectedCoin: Coin? = nil
    @State private var showDetailView: Bool = false
    
    var body: some View {
        NavigationStack {
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
                            nothingFoundMessage
                        }
                    }
                    if showPortfolio {
                        portfolioCoinsList
                            .transition(.move(edge: .trailing))
                    }
                    Spacer(minLength: 0)
                }
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .navigationDestination(isPresented: $showDetailView) {
                DetailLoadingView(coin: $selectedCoin)
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
            CircleButtonView(iconName: CircleButtonConstants.plusButtonImageName, width: 35, height: 35, shadowOpacity: 0.1)
                .animation(nil, value: UUID())
                .onTapGesture {
                    showPortfolioView.toggle()
                }
            Spacer()
            Text(showPortfolio ? HomeViewConstants.portfolioHeaderTitle : HomeViewConstants.livePricesHeaderTitle)
                .font(.pageTitle)
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: CircleButtonConstants.rightArrowImageName, width: 35, height: 35, shadowOpacity: 0.1)
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.easeOut) {
                        showPortfolio.toggle()
                    }
                    HapticManager.notification(feedbackType: .success)
                }
        }
        .padding(.horizontal)
    }
    
    private var nothingFoundMessage: some View {
        VStack {
            Spacer()
            Text("Nothing found...")
                .font(.infoLarge)
            Image("crying")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            Spacer()
        }
        .foregroundColor(Color.theme.secondaryText)
    }
    
    // All coins list
    private var allCoinsList: some View {
        List {
            ForEach(homeViewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumns: false)
                    .listRowInsets(.init(top: 10, leading: 6, bottom: 10, trailing: 14))
                    .onTapGesture {
                        segue(coin: coin)
                    }
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
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .scrollIndicators(.hidden)
        .listStyle(.plain)
    }
    
    // Column header
    private var columnHeader: some View {
        HStack {
            HStack(spacing: 4) {
                Text(HomeViewConstants.listCoinHeader)
                Image(systemName: HomeViewConstants.sortingIndicatorImageName)
                    .opacity((homeViewModel.sortOption == .rank || homeViewModel.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: homeViewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    homeViewModel.sortOption = homeViewModel.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text(HomeViewConstants.listHoldingsHeader)
                    Image(systemName: HomeViewConstants.sortingIndicatorImageName)
                        .opacity((homeViewModel.sortOption == .holdings || homeViewModel.sortOption == .holdingReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: homeViewModel.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        homeViewModel.sortOption = homeViewModel.sortOption == .holdings ? .holdingReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4) {
                Text(HomeViewConstants.listPriceHeader)
                Image(systemName: HomeViewConstants.sortingIndicatorImageName)
                    .opacity((homeViewModel.sortOption == .price || homeViewModel.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: homeViewModel.sortOption == .price ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    homeViewModel.sortOption = homeViewModel.sortOption == .price ? .priceReversed : .price
                }
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    homeViewModel.reloadData()
                }
            } label: {
                Image(systemName: HomeViewConstants.refreshButtonImageName)
            }
            .rotationEffect(Angle(degrees: homeViewModel.isLoading ? 360 : 0), anchor: .center)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}

extension HomeView {
    private func segue(coin: Coin) {
        selectedCoin = coin
        showDetailView.toggle()
    }
}
