import SwiftUI

struct AppShellView<Content: View>: View {
    @Binding var selectedTab: RootTab
    let content: Content

    init(selectedTab: Binding<RootTab>, @ViewBuilder content: () -> Content) {
        _selectedTab = selectedTab
        self.content = content()
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [AppTheme.Palette.skylineTop, AppTheme.Palette.skylineBottom],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            RadialGradient(
                colors: [AppTheme.Palette.skylineGlow, .clear],
                center: .top,
                startRadius: 40,
                endRadius: 560
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                AppTrafficLightsView()
                    .padding(.top, 18)
                    .padding(.leading, 18)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(spacing: 0) {
                    AppNavigationBarView(selectedTab: $selectedTab)

                    content
                        .background(AppTheme.Palette.panelFill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
            .frame(width: AppTheme.Layout.contentWidth, height: AppTheme.Layout.contentHeight)
            .background(AppTheme.Palette.windowPaper)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.Layout.windowCorner))
            .shadow(color: .black.opacity(0.12), radius: 28, y: 16)
            .padding(AppTheme.Layout.outerPadding)
        }
    }
}
