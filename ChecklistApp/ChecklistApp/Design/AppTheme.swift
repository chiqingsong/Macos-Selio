import SwiftUI

enum AppTheme {
    enum Palette {
        static let skylineTop = Color(red: 0.82, green: 0.74, blue: 0.81)
        static let skylineBottom = Color(red: 0.89, green: 0.74, blue: 0.75)
        static let windowPaper = Color(red: 0.93, green: 0.92, blue: 0.88)
        static let panelFill = Color(red: 0.96, green: 0.95, blue: 0.92)
        static let rowFill = Color(red: 0.95, green: 0.94, blue: 0.90)
        static let accent = Color(red: 0.79, green: 0.41, blue: 0.23)
        static let accentMuted = Color(red: 0.79, green: 0.41, blue: 0.23).opacity(0.14)
        static let ink = Color(red: 0.15, green: 0.14, blue: 0.13)
        static let secondaryInk = Color(red: 0.42, green: 0.40, blue: 0.37)
        static let divider = Color.black.opacity(0.08)
        static let success = Color(red: 0.38, green: 0.56, blue: 0.38)
        static let failure = Color(red: 0.71, green: 0.28, blue: 0.22)
    }

    enum Layout {
        static let windowCorner: CGFloat = 38
        static let contentWidth: CGFloat = 1120
        static let contentHeight: CGFloat = 860
        static let outerPadding: CGFloat = 26
        static let innerPadding: CGFloat = 28
        static let rowCorner: CGFloat = 14
        static let sectionSpacing: CGFloat = 26
    }
}
