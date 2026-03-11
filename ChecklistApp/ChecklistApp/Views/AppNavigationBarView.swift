import SwiftUI

struct AppNavigationBarView: View {
    @Binding var selectedTab: RootTab

    var body: some View {
        VStack(spacing: 22) {
            Text(Date.now.formatted(.dateTime.weekday(.wide).month(.abbreviated).day()))
                .font(AppTheme.Typography.mono(19))
                .foregroundStyle(AppTheme.Palette.secondaryInk)

            HStack(spacing: 18) {
                ForEach(RootTab.allCases, id: \.self) { tab in
                    Button(tab.title, action: {
                        selectedTab = tab
                    })
                    .buttonStyle(.plain)
                    .font(AppTheme.Typography.mono(18))
                    .foregroundStyle(selectedTab == tab ? AppTheme.Palette.accent : AppTheme.Palette.secondaryInk)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(selectedTab == tab ? AppTheme.Palette.accentMuted : AppTheme.Palette.headerPaper.opacity(0.001))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .padding(.top, 18)
        .padding(.horizontal, 34)
        .padding(.bottom, 24)
        .background(AppTheme.Palette.headerPaper)
    }
}
