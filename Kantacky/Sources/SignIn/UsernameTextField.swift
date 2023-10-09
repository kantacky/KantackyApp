import SwiftUI

struct UsernameTextField: View {
    @Binding private var text: String
    private let placeholder: String

    init(
        text: Binding<String>,
        placeholder: String
    ) {
        self._text = text
        self.placeholder = placeholder
    }

    var body: some View {
        TextField(text: self.$text) {
            Text(self.placeholder)
        }
        .padding()
        .background(Color(.textFieldBackground))
        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
    }
}

#Preview {
    @State var text: String = ""

    return UsernameTextField(
        text: $text,
        placeholder: "Username"
    )
}
