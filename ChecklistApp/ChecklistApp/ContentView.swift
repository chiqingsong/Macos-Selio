import SwiftUI

struct ContentView: View {
    @State private var selectedTab: RootTab = .chiqing

    var body: some View {
        AppShellView(selectedTab: $selectedTab) {
            Group {
                switch selectedTab {
                case .chiqing:
                    TodayView()
                case .franklin:
                    FranklinView()
                case .settings:
                    SettingsView()
                }
            }
        }
        .frame(minWidth: 1280, minHeight: 920)
    }
}

#Preview {
    ContentView()
}
