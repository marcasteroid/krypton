//
//  StatisticView.swift
//  Krypton
//
//  Created by Marco Margarucci on 11/09/23.
//

import SwiftUI

struct StatisticView: View {
    // MARK: - Properties
    let statistic: Statistic
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(statistic.title)
                .font(.info)
                .foregroundColor(Color.theme.secondaryText)
            Text(statistic.value)
                .font(.textBody)
                .foregroundColor(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: StatisticViewConstants.arrow)
                    .font(.bodySemiBoldSmall)
                    .rotationEffect(Angle(degrees: (statistic.percentageChange ?? 0) >= 0 ? 0 : 180))
                Text(statistic.percentageChange?.asPercentString() ?? "")
                    .font(.bodySemiBold)
            }
            .foregroundColor((statistic.percentageChange ?? 0) >= 0 ? Color.theme.blue : Color.theme.red)
            .opacity(statistic.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(statistic: dev.statistic1)
            StatisticView(statistic: dev.statistic2)
            StatisticView(statistic: dev.statistic3)
        }
    }
}
