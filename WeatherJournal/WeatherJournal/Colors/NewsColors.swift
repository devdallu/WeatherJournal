//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import SwiftUI

@MainActor
public enum NewsColors {
    // Backgrounds
    public static var brandBlueGradient1: Color = NewsColors.brandBluePrimary
    public static var brandBlueGradient2: Color = NewsColors.brandBlueGradient
    public static var brandGrayBackground: Color = NewsColors.systemGray1
    public static var commonBackground: (Bool) -> Color = { darkMode in darkMode ? NewsColors.systemGray2 : NewsColors.systemGray8}
    public static var highlightedBackground: (Bool) -> Color = { darkMode in darkMode ? NewsColors.systemGray2 : NewsColors.systemWhite }
    public static var viewBackground: (Bool) -> Color = { darkMode in darkMode ? NewsColors.systemGray6.opacity(0.05) : NewsColors.systemGray3.opacity(0.05) }
    
    // List
    public static var rowDivider: (Bool) -> Color = { darkMode in darkMode ? NewsColors.systemGray1 : NewsColors.systemGray7 }
    
    // Text
    public static var commonText: (Bool) -> Color = { darkMode in darkMode ? NewsColors.systemWhite : NewsColors.systemblack }
    public static var secondaryText: (Bool) -> Color = { darkMode in darkMode ? NewsColors.systemGray7 : NewsColors.systemGray4 }
    public static var tertiaryText: (Bool) -> Color = { darkMode in darkMode ? NewsColors.systemGray6 : NewsColors.systemGray4 }
    public static var titleText: (Bool) -> Color = { darkMode in darkMode ? NewsColors.systemGray6 : NewsColors.systemGray3 }
    
    public static var action: (Bool) -> Color = { darkMode in darkMode ? NewsColors.utilityBlue3 : NewsColors.utilityBlue1 }
    public static var surfaceOutline: (Bool) -> Color = { darkMode in darkMode ? NewsColors.systemGray4 : NewsColors.systemGray7 }
}

private extension NewsColors {
    static let brandBluePrimary  = Color(red: 0x16 / 255, green: 0x4c / 255, blue: 0x99 / 255)
    static let brandBlueGradient = Color(red: 0x03 / 255, green: 0x2c / 255, blue: 0x77 / 255) // Rename this color when design is updated
    
    static let systemGray1 = Color(red: 0x11 / 255, green: 0x11 / 255, blue: 0x11 / 255)
    static let systemGray2 = Color(red: 0x25 / 255, green: 0x25 / 255, blue: 0x25 / 255)
    static let systemGray3 = Color(red: 0x4a / 255, green: 0x4a / 255, blue: 0x4a / 255)
    static let systemGray4 = Color(red: 0x70 / 255, green: 0x70 / 255, blue: 0x70 / 255)
    static let systemGray5 = Color(red: 0x94 / 255, green: 0x94 / 255, blue: 0x94 / 255)
    static let systemGray6 = Color(red: 0xbe / 255, green: 0xbe / 255, blue: 0xbe / 255)
    static let systemGray7 = Color(red: 0xe2 / 255, green: 0xe2 / 255, blue: 0xe2 / 255)
    static let systemGray8 = Color(red: 0xf4 / 255, green: 0xf5 / 255, blue: 0xf7 / 255)
    static let systemWhite = Color.white
    
    static let utilityBlue1 = Color(red: 0x31 / 255, green: 0x57 / 255, blue: 0xa1 / 255)
    static let utilityBlue3 = Color(red: 0x2a / 255, green: 0xa2 / 255, blue: 0xe1 / 255)
    
    static let systemblack = Color(red: 0x00, green: 0x00, blue: 0x00)

}
