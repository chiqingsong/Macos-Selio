import SwiftUI

struct AppNavigationBarView: View {
    @Binding var selectedTab: RootTab

    var body: some View {
        VStack(spacing: 22) {
            Text(Date.now.formatted(.dateTime.weekday(.wide).month(.abbreviated).day()))
                .font(.system(.title2, design: .monospaced))
                .foregroundStyle(AppTheme.Palette.secondaryInk)

            HStack(spacing: 18) {
                ForEach(RootTab.allCases, id: \.self) { tab in
                    Button(tab.title, action: {
                        selectedTab = tab
                    })
                    .buttonStyle(.plain)
                    .font(.system(.title3, design: .monospaced))
                    .foregroundStyle(selectedTab == tab ? AppTheme.Palette.accent : AppTheme.Palette.secondaryInk)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(selectedTab == tab ? AppTheme.Palette.accentMuted : Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .padding(.top, 18)
        .padding(.horizontal, 34)
        .padding(.bottom, 24)
        .background(AppTheme.Palette.windowPaper)
    }
}
