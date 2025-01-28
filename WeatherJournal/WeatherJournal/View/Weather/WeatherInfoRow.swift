//
//  WeatherInfoRow.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import SwiftUI

struct WeatherInfoCard: View {
    let info: WeatherInfoConvertible
    @SwiftUI.Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: UIConstants.spacing) {
            headerView
            valueText
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(cardBackground)
        .cornerRadius(UIConstants.cornerRadius)
        .shadow(color: NewsColors.commonBackground(colorScheme == .dark), radius: UIConstants.radius, y: UIConstants.y)
    }
    
    private var headerView: some View {
        HStack {
            Image(systemName: info.icon)
                .font(.skyHeadline)
                .foregroundStyle(NewsColors.brandBlueGradient1)
            Text(info.title)
                .font(.skyBodyMedium1)
                .foregroundStyle(NewsColors.secondaryText(colorScheme == .dark))
        }
    }
    
    private var valueText: some View {
        Text(info.value)
            .font(.skyHeadline)
            .lineLimit(UIConstants.Limt)
            .minimumScaleFactor(UIConstants.scaleFactor)
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: UIConstants.cornerRadius)
            .fill(NewsColors.commonBackground(colorScheme == .dark))
    }
}

// MARK: - Constants
private extension WeatherInfoCard {
    enum UIConstants {
        static let spacing: CGFloat = 8
        static let cornerRadius: CGFloat = 12
        static let scaleFactor: CGFloat = 0.8
        static let Limt: Int = 1
        static let blackOpacity: CGFloat = 0.4
        static let grayOpacity: CGFloat = 0.4
        static let radius: CGFloat = 2
        static let y: CGFloat = 1
    }
}

#Preview {
    WeatherInfoCard(info: WeatherInfo(icon: "heart", title: "test", value: "test"))
}
