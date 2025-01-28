//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import SwiftUI

@MainActor
extension Font {
    public static var skyBody1: Font {
        Font.custom(Self.Name.regular, fixedSize: Self.getFontSize(12, 14, 15, 16, 18, 22, 24, 26, 30, 32, 36, 38))
    }
    
    public static var skyBodyMedium1: Font {
        Font.custom(Self.Name.medium, fixedSize: Self.getFontSize(12, 14, 15, 16, 18, 22, 24, 26, 30, 32, 36, 38))
    }
    
    public static var skyCaption1: Font {
        Font.custom(Self.Name.regular, fixedSize: Self.getFontSize(12, 12, 12, 12, 14, 18, 20, 20, 24, 26, 30, 32))
    }
    
    public static var skyCaption2: Font {
        Font.custom(Self.Name.regular, fixedSize: Self.getFontSize(12, 12, 12, 12, 14, 18, 20, 20, 20, 20, 20, 20))
    }
    
    public static var skyDisplay3: Font {
        Font.custom(Self.Name.regular, fixedSize: Self.getFontSize(28, 28, 32, 32, 36, 40, 42, 44, 48, 50, 52, 54))
    }

    public static var skyHeadline: Font {
        Font.custom(Self.Name.headline, fixedSize: Self.getFontSize(28, 28, 32, 32, 36, 40, 42, 44, 48, 50, 52, 54))
    }
    
    public static var skySubtitle2: Font {
        Font(UIFont.skySubtitle2)
    }
}

extension UIFont {
    public static var skySubtitle2: UIFont {
        UIFont(name: Font.Name.medium, size: 12) ?? .init()
    }
}

@MainActor
private extension Font {
    enum Name {
        static let regular = "SkyText-Regular"
        static let medium  = "SkyTextMedium-Regular"
        static let headline = "Sky Headline"
    }
    
    enum FileName: String, CaseIterable {
        case regular = "SkyTextRegular.ttf"
        case medium = "SkyTextMedium.ttf"
        case headline = "SkyHeadline-SemiBold-Regular.ttf"
    }
    
    // swiftlint:disable:next cyclomatic_complexity function_parameter_count
    static func getFontSize(
        _ extraSmall: CGFloat,
        _ small: CGFloat,
        _ medium: CGFloat,
        _ large: CGFloat,
        _ extraLarge: CGFloat,
        _ extraExtraLarge: CGFloat,
        _ extraExtraExtraLarge: CGFloat,
        _ accessibility1: CGFloat,
        _ accessibility2: CGFloat,
        _ accessibility3: CGFloat,
        _ accessibility4: CGFloat,
        _ accessibility5: CGFloat
    ) -> CGFloat {
        switch SkyText.shared.currentSize {
        case .extraSmall:           return extraSmall
        case .small:                return small
        case .medium:               return medium
        case .large:                return large
        case .extraLarge:           return extraLarge
        case .extraExtraLarge:      return extraExtraLarge
        case .extraExtraExtraLarge: return extraExtraExtraLarge
        case .accessibility1:       return accessibility1
        case .accessibility2:       return accessibility2
        case .accessibility3:       return accessibility3
        case .accessibility4:       return accessibility4
        case .accessibility5:       return accessibility5
        }
    }
}

extension View {
    /// This should be called on the view in the preview block to load Sky fonts in the preview.
    public func loadSkyFonts() -> some View {
        Font.FileName.allCases.forEach { font in
            guard let url = Bundle.main.url(forResource: font.rawValue, withExtension: nil) else { return }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
        return self
    }
}
