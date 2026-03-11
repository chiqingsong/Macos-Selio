import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Checklist Demo")
                .font(.system(.largeTitle, design: .monospaced))
            Text("Today, Yesterday, and Settings will be implemented in the next tasks.")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(24)
    }
}

#Preview {
    ContentView()
}
