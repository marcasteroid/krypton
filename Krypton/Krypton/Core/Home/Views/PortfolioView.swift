//
//  PortfolioView.swift
//  Krypton
//
//  Created by Marco Margarucci on 11/09/23.
//

import SwiftUI
import AVFoundation

struct PortfolioView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var quantityText: String = ""
    @State private var isSaved: Bool = false
    
    var body: some View {
        ZStack {
            // Background layer
            Color.theme.background
                .ignoresSafeArea()
            VStack(spacing: 0) {
                portfolioHeader
                SearchBarView(searchText: $homeViewModel.searchText)
                coinLogoList
                if selectedCoin != nil {
                    portfolioInputSection
                    saveButton
                }
                Spacer()
            }
        }
        .onChange(of: homeViewModel.searchText) { newValue in
            if newValue == "" { removeSelectedCoin() }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

// MARK: - Extensions

extension PortfolioView {
    // Portfolio header
    private var portfolioHeader: some View {
        HStack {
            Text(PortfolioViewConstants.pageTitle)
                .font(.pageTitle)
                .foregroundColor(Color.theme.accent)
                .padding(.top, 20)
                .padding(.leading, 10)
            Spacer()
            CircleButtonView(iconName: CircleButtonConstants.closeImageName, width: 20, height: 20, shadowOpacity: 0.0)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding(.top, 25)
        }
        .padding(.leading, 5)
    }
    
    // Scroll view
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 20) {
                ForEach(homeViewModel.searchText.isEmpty ? homeViewModel.portfolioCoins : homeViewModel.allCoins) { coin in
                    VStack {
                        ZStack(alignment: .bottomTrailing) {
                            CoinImageView(coin: coin)
                                .frame(width: 50)
                                .padding(4)
                                .onTapGesture {
                                    withAnimation(.easeIn) {
                                        updateSelectedCoin(coin: coin)
                                    }
                            }
                            Image(systemName: PortfolioViewConstants.selectedCoinImageName)
                                .imageScale(.small)
                                .foregroundColor(Color.theme.green)
                                .frame(width: 18, height: 18)
                                .opacity((selectedCoin?.id == coin.id) ? 1.0 : 0.0)
                        }
                        Text(coin.name)
                            .font(.textBody)
                        Text(coin.symbol.uppercased())
                            .font(.info)
                            .foregroundColor(Color.theme.accent)
                    }
                }
            }
            .frame(height: 100)
            .padding([.top], 10)
            .padding(.leading)
        })
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                HStack {
                    Text(PortfolioViewConstants.currentPriceOfCoin)
                    Text(selectedCoin?.symbol.uppercased() ?? "")
                }
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text(PortfolioViewConstants.amountInPortfolio)
                Spacer()
                TextField(PortfolioViewConstants.textFieldAmountPlaceholder, text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text(PortfolioViewConstants.currentValue)
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .font(.bodySemiBold)
        .padding([.top, .leading, .trailing])
    }
    
    private var saveButton: some View {
        Button {
            saveButtonTapped()
        } label: {
            Text(isSaved ? PortfolioViewConstants.savedButtonTitle : PortfolioViewConstants.saveButtonTitle)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
        }
        .background(Color.theme.button)
        .foregroundColor(.white)
        .font(.bodySemiBold)
        .cornerRadius(10)
        .padding()
        .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
        .disabled(isSaved)
    }
    
    // MARK: - Functions
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonTapped() {
        guard let coin = selectedCoin,
              let amount = Double(quantityText) else { return }
        
        // Save portfolio
        homeViewModel.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation {
            isSaved = true
            AudioServicesPlaySystemSound(1008)
        }
        
        // Hide the keyboard
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                isSaved = false
                removeSelectedCoin()
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        homeViewModel.searchText = ""
    }
    
    private func updateSelectedCoin(coin: Coin) {
        selectedCoin = coin
        if let portfolioCoin = homeViewModel.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
}
