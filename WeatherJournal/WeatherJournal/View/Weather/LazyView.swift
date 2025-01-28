//
//  LazyView.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(@ViewBuilder _ build: @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
