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
                    Button {
                        saveButtonTapped()
                        print("HELLO")
                    } label: {
                        Text(isSaved ? PortfolioViewConstants.savedButtonTitle : PortfolioViewConstants.saveButtonTitle)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                    }
                    .background(Color.theme.accent)
                    .foregroundColor(.white)
                    .font(.bodySemiBold)
                    .cornerRadius(10)
                    .padding()
                    .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
                    .disabled(isSaved)
                }

                Spacer()
            }
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
                ForEach(homeViewModel.allCoins) { coin in
                    VStack {
                        CoinImageView(coin: coin)
                            .frame(width: 75)
                            .padding(4)
                            .onTapGesture {
                                withAnimation(.easeIn) {
                                    selectedCoin = coin
                                }
                            }
                        .background(RoundedRectangle(cornerRadius: 10).stroke((selectedCoin?.id == coin.id) ? Color.theme.blue : Color.clear, lineWidth: 1))
                        Text(coin.name)
                            .font(.textBody)
                        Text(coin.symbol.uppercased())
                            .font(.info)
                            .foregroundColor(Color.theme.accent)
                    }
                }
            }
            .frame(height: 100)
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
        .padding()
    }
    
    // MARK: - Functions
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonTapped() {
        guard let coin = selectedCoin else { return }
        
        // TODO: - Save portfolio
        
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
}
