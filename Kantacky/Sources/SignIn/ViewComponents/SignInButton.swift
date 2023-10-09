import SwiftUI

struct SignInButton: View {
    private let action: () -> Void
    private let text: String
    private let disabled: Bool

    init(
        _ text: String,
        disabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.action = action
        self.text = text
        self.disabled = disabled
    }

    var body: some View {
        Button {
            self.action()
        } label: {
            Text(self.text)
                .frame(maxWidth: 128, maxHeight: 48)
        }
        .disabled(self.disabled)
        .foregroundStyle(Color.white)
        .background(self.disabled ? Color.gray : Color.blue)
        .clipShape(Capsule())
    }
}

#Preview {
    VStack {
        SignInButton("Continue", disabled: true) {
            print("Continue Button Tapped!!")
        }

        SignInButton("Sign In") {
            print("SignIn Button Tapped!!")
        }
    }
}
