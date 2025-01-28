//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import Foundation
import SwiftUI

public struct DarkModeEnvironmentKey: EnvironmentKey {
    public static let defaultValue: Bool = false
}

public extension EnvironmentValues {
    var darkMode: Bool {
        get { self[DarkModeEnvironmentKey.self] }
        set { self[DarkModeEnvironmentKey.self] = newValue }
    }
}

@MainActor
public class DarkMode: ObservableObject {
    public static let shared = DarkMode()
    
    @Published public var enabled = false
}
