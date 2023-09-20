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
            ScrollView {
                VStack(spacing: 20) {
                    overviewSection
                    additionalSection
                }
            }
            .padding()
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
}
