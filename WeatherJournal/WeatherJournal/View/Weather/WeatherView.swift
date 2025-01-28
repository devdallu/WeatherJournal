//
//  WeatherView.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 18/01/25.
//
import SwiftUI
import CoreLocation

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel
    @StateObject private var locationManager = LocationManager.shared
    
    var body: some View {
        LazyView {
            content
                .onAppear {
                    if let location = locationManager.location {
                        Task(priority: .userInitiated) {
                            await handleLocationChange(location)
                        }
                    }
                }
                .onChange(
                    of: locationManager.location
                ) {
                    _,
                    newLocation in
                    Task(priority: .userInitiated) {
                        await handleLocationChange(newLocation)
                    }
                }
                .navigationTitle("Weather Report")
        }
    }
    
    // MARK: - Weather View Content
    @ViewBuilder
    private var content: some View {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            LazyView { weatherContentView() }
        case .denied, .restricted:
            LazyView { LocationDeniedView(locationManager: locationManager) }
        case .notDetermined:
            LazyView {
                LocationPermissionView(
                    requestPermission: {
                        locationManager.requestLocationPermission()
                    }
                )
            }
        @unknown default:
            Text("Unknown authorization status")
        }
    }
    
    // MARK: - Weather Content Based on ViewModel State
    @ViewBuilder
    private func weatherContentView() -> some View {
        switch viewModel.state {
        case .idle:
            LazyView { IdleView(locationManager: locationManager) }
        case .loading:
            LazyView { LoadingView() }
        case .loaded(let weather):
            LazyView { WeatherContentView(weather: weather) }
        case .error(let message):
            LazyView {
                ErrorView(
                    message: message,
                    retryAction: {
                        Task(priority: .userInitiated) {
                            await handleRetry()
                        }
                    }
                )
            }
        }
    }
}

extension WeatherView {
    // MARK: - Handle Location Changes
    private func handleLocationChange(_ newLocation: CLLocation?) async {
        if let location = newLocation {
            await viewModel.fetchWeatherStatus(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
        }
    }
    
    // MARK: - Handle Retry Action
    private func handleRetry() async {
        if let location = locationManager.location {
            await viewModel.fetchWeatherStatus(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
        }
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel(
        weatherService: WeatherService(),
        connectivityService: ConnectivityService()
    ))
}
