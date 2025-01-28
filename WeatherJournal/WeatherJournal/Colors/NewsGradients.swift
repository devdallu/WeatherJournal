//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import SwiftUI

@MainActor
public enum NewsGradients {
    public static var brandBlueBackground: LinearGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: NewsColors.brandBlueGradient1, location: 0.00),
            Gradient.Stop(color: NewsColors.brandBlueGradient2, location: 1.00),
        ],
        startPoint: UnitPoint(x: 0, y: 0),
        endPoint: UnitPoint(x: 1, y: 1)
    )
}
