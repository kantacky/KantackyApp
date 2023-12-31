import SwiftUI

struct SignInTextField: View {
    @Binding private var text: String
    private var field: SignInReducer.Field
    private let disabled: Bool

    init(
        text: Binding<String>,
        field: SignInReducer.Field,
        disabled: Bool = false
    ) {
        self._text = text
        self.field = field
        self.disabled = disabled
    }

    var body: some View {
        switch self.field {
        case .username:
            TextField("Username", text: self.$text)
                .disabled(self.disabled)
                .textContentType(.username)
                .textInputAutocapitalization(.never)
                .keyboardType(.asciiCapable)
                .padding()
                .background(Color(.textFieldBackground))
                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))

        case .password:
            SecureField("password", text: self.$text)
                .disabled(self.disabled)
                .textContentType(.password)
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
            field: .username
        )

        SignInTextField(
            text: $text,
            field: .password
        )
    }
}
