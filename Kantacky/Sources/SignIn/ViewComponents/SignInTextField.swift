import SwiftUI

struct SignInTextField: View {
    @Binding private var text: String
    private let placeholder: String
    private var field: SignInReducer.Field
    private let disabled: Bool

    init(
        text: Binding<String>,
        placeholder: String,
        field: SignInReducer.Field,
        disabled: Bool = false
    ) {
        self._text = text
        self.placeholder = placeholder
        self.field = field
        self.disabled = disabled
    }

    var body: some View {
        switch self.field {
        case .username:
            TextField(text: self.$text) {
                Text(self.placeholder)
            }
            .disabled(self.disabled)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .keyboardType(.alphabet)
            .padding()
            .background(Color(.textFieldBackground))
            .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))

        case .password:
            SecureField(text: self.$text) {
                Text(self.placeholder)
            }
            .disabled(self.disabled)
            .padding()
            .background(Color(.textFieldBackground))
            .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
        }
    }
}

#Preview {
    @State var text: String = ""
    @FocusState var focusedField: SignInReducer.Field?

    return VStack {
        SignInTextField(
            text: $text,
            placeholder: "Username",
            field: .username
        )

        SignInTextField(
            text: $text,
            placeholder: "Password",
            field: .password
        )
    }
}
