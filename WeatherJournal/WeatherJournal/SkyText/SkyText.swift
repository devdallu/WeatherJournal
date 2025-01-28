//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import Foundation
import SwiftUI

@MainActor
public struct TextSizeEnvironmentKey: @preconcurrency EnvironmentKey {
    public static let defaultValue: SkyText.Size = .large
}

@MainActor
public extension EnvironmentValues {
    var textSize: SkyText.Size {
        get { self[TextSizeEnvironmentKey.self] }
        set { self[TextSizeEnvironmentKey.self] = newValue }
    }
}

@MainActor
public class SkyText: ObservableObject {
    public static let shared = SkyText()
    
    @Published public var currentSize = Size.large
    
    public enum Size: String, CaseIterable {
        case extraSmall
        case small
        case medium
        case large // Default. 0 slider position.
        case extraLarge
        case extraExtraLarge
        case extraExtraExtraLarge
        case accessibility1
        case accessibility2
        case accessibility3
        case accessibility4
        case accessibility5
        
        /// Init to create SkyTextSize from slider value
        /// - Parameter sliderPosition: Currently supported values from -2 to 2 with 0 being default.
        public init?(sliderPosition: Int) {
            switch sliderPosition {
            case -2:
                self = .small
            case -1:
                self = .medium
            case 0:
                self = .large
            case 1:
                self = .extraLarge
            case 2:
                self = .extraExtraLarge
            default:
                return nil // Unsupported slider value.
            }
        }
    }
}
