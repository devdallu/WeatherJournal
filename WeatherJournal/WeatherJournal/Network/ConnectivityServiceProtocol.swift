//
//  ConnectivityServiceProtocol.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//
import Foundation
import Connectivity

protocol ConnectivityServiceProtocol {
    func checkConnectionStatus() async -> Connectivity.Status
}

// Actual implementation that wraps the third-party Connectivity
final class ConnectivityService: ConnectivityServiceProtocol {
    private let connectivity: Connectivity
    
    init(connectivity: Connectivity = Connectivity()) {
        self.connectivity = connectivity
    }
    
    func checkConnectionStatus() async -> Connectivity.Status {
        await withCheckedContinuation { continuation in
            connectivity.checkConnectivity { connectivity in
                continuation.resume(returning: connectivity.status)
            }
        }
    }
}
