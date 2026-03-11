import SwiftUI

struct AppTrafficLightsView: View {
    var body: some View {
        HStack(spacing: 12) {
            Circle().fill(Color(red: 0.97, green: 0.36, blue: 0.33))
            Circle().fill(Color(red: 0.95, green: 0.78, blue: 0.14))
            Circle().fill(Color(red: 0.20, green: 0.77, blue: 0.35))
        }
        .frame(width: 84, height: 18)
    }
}
