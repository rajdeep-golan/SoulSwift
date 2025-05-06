import SwiftUI

struct ChatView: View {
    @Environment(ChatViewModel.self) private var viewModel
    @Environment(\.colorScheme) private var colorScheme

    @State private var scrolledToLast = true
    private let last = "last"

    var body: some View {
        ScrollViewReader { proxy in
            List {
                Group {
                    ForEach(viewModel.messages.values, content: message)
                    Spacer(minLength: 16)
                        .id(last)
                        .onAppear { scrolledToLast = true }
                        .onDisappear { scrolledToLast = false }
                }
                .listRowBackground(EmptyView())
                .listRowSeparator(.hidden)
                .onChange(of: viewModel.messages.values.last) {
                    if scrolledToLast {
                        proxy.scrollTo(last, anchor: .bottom)
                    }
                }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
        }
        .animation(.default, value: viewModel.messages)
        .alert("Error while connecting to Chat", isPresented: .constant(viewModel.error != nil)) {
            Button("OK", role: .cancel) {}
        }
    }

    @ViewBuilder
    private func message(_ message: Message) -> some View {
        Group {
            switch message.content {
            case let .userTranscript(text):
                userTranscript(text, dark: colorScheme == .dark)
            case let .agentTranscript(text):
                agentTranscript(text).opacity(message.id == viewModel.messages.keys.last ? 1 : 0.8)
            }
        }
        .transition(.blurReplace)
    }

    @ViewBuilder
    private func userTranscript(_ text: String, dark: Bool) -> some View {
        HStack {
            Spacer(minLength: 16)
            Text(text.trimmingCharacters(in: .whitespacesAndNewlines))
                .font(.system(size: 15))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.background.secondary)
                        .stroke(.separator.secondary, lineWidth: dark ? 1 : 0)
                )
        }
    }

    @ViewBuilder
    private func agentTranscript(_ text: String) -> some View {
        HStack {
            Text(text.trimmingCharacters(in: .whitespacesAndNewlines))
                .font(.system(size: 20))
                .padding(.vertical, 8)
            Spacer(minLength: 16)
        }
    }
}
