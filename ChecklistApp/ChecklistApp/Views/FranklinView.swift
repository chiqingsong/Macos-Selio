import SwiftUI

struct FranklinView: View {
    @State private var selectedVirtue = FranklinData.virtues[8]

    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 26) {
                HStack {
                    Text("Today")
                        .font(.system(size: 34, design: .monospaced))
                        .foregroundStyle(AppTheme.Palette.ink)
                    Spacer()
                    Text("\(FranklinData.virtues.filter(\.completed).count)/13 clean")
                        .font(.system(.title3, design: .monospaced))
                        .foregroundStyle(AppTheme.Palette.ink)
                }

                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(FranklinData.virtues) { virtue in
                        Button(action: {
                            selectedVirtue = virtue
                        }) {
                            VStack(spacing: 10) {
                                Text(virtue.symbol)
                                    .font(.system(size: 28))
                                Text(virtue.name)
                                    .font(.system(.title3, design: .monospaced))
                                    .foregroundStyle(selectedVirtue == virtue ? AppTheme.Palette.accent : AppTheme.Palette.secondaryInk)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity, minHeight: 120)
                            .background(selectedVirtue == virtue ? AppTheme.Palette.accentMuted : Color.white.opacity(0.65))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                        .buttonStyle(.plain)
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("▸ \(selectedVirtue.name)")
                            .font(.system(.title3, design: .monospaced))
                            .foregroundStyle(AppTheme.Palette.success)
                        Spacer()
                        Text("[9/13]")
                            .font(.system(.title3, design: .monospaced))
                            .foregroundStyle(AppTheme.Palette.secondaryInk)
                    }

                    Text("\"\(selectedVirtue.quote)\"")
                        .font(.system(.body, design: .monospaced))
                        .foregroundStyle(AppTheme.Palette.secondaryInk)
                        .lineSpacing(4)
                }
                .padding(.top, 8)

                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        Text("Cycle [9/13]")
                            .font(.system(.title3, design: .monospaced))
                            .foregroundStyle(AppTheme.Palette.secondaryInk)
                        Spacer()
                        Text("1 fail")
                            .font(.system(.title3, design: .monospaced))
                            .foregroundStyle(AppTheme.Palette.failure)
                    }

                    ForEach(FranklinData.virtues) { virtue in
                        HStack {
                            Text(virtue.name)
                                .font(.system(size: 22, design: .monospaced))
                                .foregroundStyle(AppTheme.Palette.ink)
                            Spacer()
                            Text(virtue.completed ? "✓" : "−1")
                                .font(.system(size: 20, design: .monospaced))
                                .foregroundStyle(virtue.completed ? AppTheme.Palette.success : AppTheme.Palette.secondaryInk)
                        }
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .fill(AppTheme.Palette.divider)
                                .frame(height: 1)
                                .padding(.top, 28)
                        }
                    }
                }
            }
            .padding(AppTheme.Layout.innerPadding)
        }
    }
}
