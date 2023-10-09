import SwiftUI

struct SignInButton: View {
    private let action: () -> Void
    private let text: String

    init(
        _ text: String,
        action: @escaping () -> Void
    ) {
        self.action = action
        self.text = text
    }

    var body: some View {
        Button {
            self.action()
        } label: {
            Text(self.text)
        }
        .padding(.vertical)
        .padding(.horizontal, 32)
        .foregroundStyle(Color.white)
        .background(Color.blue)
        .clipShape(Capsule())
    }
}

#Preview {
    SignInButton("Sign In") {
        print("SignIn Button Tapped!!")
    }
}
