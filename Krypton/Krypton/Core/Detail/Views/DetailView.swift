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
    @StateObject private var detailViewModel: DetailViewModel
    @State private var showFullDescription: Bool = false;
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    
    init(coin: Coin) {
        self._detailViewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        VStack {
            detailHeader
            ChartView(coin: detailViewModel.coin)
                .padding(.horizontal)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    descriptionSection
                    overviewSection
                    additionalSection
                    websiteSection
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}

// MARK: - Extensions
extension DetailView {
    // Navigation bar trailing items
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(detailViewModel.coin.symbol.uppercased())
                .font(.textBody)
            .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: detailViewModel.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    // Detail header
    private var detailHeader: some View {
        HStack {
            Text(detailViewModel.coin.name)
                .font(.pageTitle)
                .foregroundColor(Color.theme.accent)
                .padding(.top, 20)
                .padding(.leading, 10)
            Spacer()
        }
        .padding(.leading, 5)
    }
    
    // Overview section
    private var overviewSection: some View {
        VStack {
            Text(DetailViewConstants.overviewSectionTitle)
                .font(.sectionTitle)
                .foregroundColor(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            LazyVGrid(columns: columns, alignment: .leading, spacing: spacing) {
                ForEach(detailViewModel.overviewStatistics) { statistic in
                    StatisticView(statistic: statistic)
                }
            }
        }
    }
    
    // Additional section
    private var additionalSection: some View {
        VStack {
            Text(DetailViewConstants.additionalDetailsSectionTitle)
                .font(.sectionTitle)
                .foregroundColor(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            LazyVGrid(columns: columns, alignment: .leading, spacing: spacing) {
                ForEach(detailViewModel.additionalStatistics) { statistic in
                    StatisticView(statistic: statistic)
                }
            }
        }
    }
    
    // Description section
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = detailViewModel.coinDescription, coinDescription.isNotEmpty {
                VStack {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 4)
                    Button {
                        showFullDescription.toggle()
                    } label: {
                        HStack {
                            Spacer()
                            Text(showFullDescription ? DetailViewConstants.readMoreButtonTitleExpanded : DetailViewConstants.readMoreButtonTitleNotExpanded)
                                .fontWeight(.bold)
                                .foregroundColor(Color.theme.red)
                            Image(systemName: showFullDescription ? DetailViewConstants.readMoreButtonImageExpanded : DetailViewConstants.readMoreButtonImageNotExpanded)
                        }
                    }
                    .padding(.top, 1)
                }
            }
        }
        .font(.textBody)
    }
    
    // Website section
    private var websiteSection: some View {
        HStack {
            if let websiteString = detailViewModel.websiteURL, let url = URL(string: websiteString) {
                Link(DetailViewConstants.websiteLinkTitle, destination: url)
            }
            Divider()
            if let redditString = detailViewModel.redditURL, let url = URL(string: redditString) {
                Link(DetailViewConstants.redditLinkTitle, destination: url)
            }
        }
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.infoLarge)
    }
}
