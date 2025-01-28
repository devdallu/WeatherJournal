//
//  WeatherInfoRow.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//
import SwiftUI

struct WeatherContentView: View {
    let weather: WeatherResponse
    private let dataProvider = WeatherDataProvider()
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(
                        .adaptive(
                            minimum: UIConstants.minimum,
                            maximum: UIConstants.maximum
                        ),
                        spacing: UIConstants.spacing
                    )
                ],
                spacing: UIConstants.spacing
            ) {
                ForEach(
                    dataProvider.getWeatherInfo(
                        from: weather
                    ),
                    id: \.title
                ) { info in
                    WeatherInfoCard(
                        info: info
                    )
                }
            }
            .padding()
        }
    }
}

// MARK: - Constants
private extension WeatherContentView {
    enum UIConstants {
        static let spacing: CGFloat = 16
        static let minimum: CGFloat = 160
        static let maximum: CGFloat = 200
    }
}

// MARK: - Preview
#Preview {
    WeatherContentView(
        weather: .init(
            coord: .init(
                lon: 77.5946,
                lat: 12.9716
            ),
            weather: [.init(
                id: 800,
                main: "Clear",
                description: "clear sky",
                icon: "01d"
            )],
            base: "stations",
            main: .init(
                temp: 298.15,
                feelsLike: 300.0,
                tempMin: 295.15,
                tempMax: 300.15,
                pressure: 1012,
                humidity: 70,
                seaLevel: 1012,
                grndLevel: 1000
            ),
            visibility: 10000,
            wind: .init(
                speed: 4.1,
                deg: 80,
                gust: 7.5
            ),
            clouds: .init(
                all: 0
            ),
            dt: 1618317040,
            sys: .init(
                country: "IN",
                sunrise: 1618282134,
                sunset: 1618325504
            ),
            timezone: 19800,
            id: 1277333,
            name: "Bangalore",
            cod: 200
        )
    )
}
