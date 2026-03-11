import Foundation

enum RootTab: CaseIterable {
    case chiqing
    case franklin
    case settings

    var title: String {
        switch self {
        case .chiqing:
            "CHIQING"
        case .franklin:
            "FRANKLIN"
        case .settings:
            "SETTINGS"
        }
    }
}
