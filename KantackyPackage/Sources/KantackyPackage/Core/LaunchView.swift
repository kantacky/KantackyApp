import SwiftUI

struct LaunchView: View {
    var body: some View {
        VStack(spacing: 64) {
            Image(.kantacky)
                .resizable()
                .scaledToFit()
                .frame(width: 128)
            ProgressView()
        }
    }
}

#Preview {
    LaunchView()
}
