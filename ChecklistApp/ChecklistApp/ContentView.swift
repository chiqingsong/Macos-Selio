import SwiftUI

struct ContentView: View {
    @State private var selectedTab: RootTab = .today

    var body: some View {
        VStack(spacing: 0) {
            header

            Group {
                switch selectedTab {
                case .today:
                    TodayView()
                case .yesterday:
                    YesterdayView()
                case .settings:
                    SettingsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.opacity(0.55))
        }
        .background(
            LinearGradient(
                colors: [Color(red: 0.94, green: 0.84, blue: 0.86), Color(red: 0.82, green: 0.79, blue: 0.89)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }

    private var header: some View {
        VStack(spacing: 18) {
            Text(Date.now.formatted(.dateTime.weekday(.wide).month().day()))
                .font(.system(size: 24, weight: .regular, design: .monospaced))
                .foregroundStyle(.black.opacity(0.6))
                .padding(.top, 22)

            HStack(spacing: 16) {
                tabButton(.today, title: "TODAY")
                tabButton(.yesterday, title: "YESTERDAY")
                tabButton(.settings, title: "SETTINGS")
            }
        }
        .padding(.horizontal, 28)
        .padding(.bottom, 20)
        .background(Color(red: 0.89, green: 0.88, blue: 0.84).opacity(0.92))
    }

    private func tabButton(_ tab: RootTab, title: String) -> some View {
        Button(title) {
            selectedTab = tab
        }
        .buttonStyle(.plain)
        .font(.system(size: 18, weight: .regular, design: .monospaced))
        .foregroundStyle(selectedTab == tab ? Color.orange : Color.black.opacity(0.58))
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
}

enum RootTab {
    case today
    case yesterday
    case settings
}

#Preview {
    ContentView()
}
