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
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            RoundedRectangle(cornerRadius: AppTheme.Layout.windowCorner)
                .fill(AppTheme.Palette.windowPaper)
                .frame(width: AppTheme.Layout.contentWidth, height: AppTheme.Layout.contentHeight)
                .overlay(alignment: .top) {
                    AppNavigationBarView(selectedTab: $selectedTab)
                }
                .overlay(alignment: .bottom) {
                    content
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.top, 120)
                        .background(AppTheme.Palette.panelFill)
                        .clipShape(
                            RoundedRectangle(cornerRadius: AppTheme.Layout.windowCorner)
                        )
                }
                .shadow(color: .black.opacity(0.08), radius: 24, y: 18)
                .padding(AppTheme.Layout.outerPadding)
        }
    }
}
