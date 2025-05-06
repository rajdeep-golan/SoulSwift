import SwiftUI
//import GoogleGenerativeAI

struct AIChatView: View {
    @Environment(\.presentationMode) var presentationMode
    private var GEMINI_API_KEY = "AIzaSyBzi9fdftJex9Jq-InWkwZtM_CpHcPJkdw"
//    lazy var geminiPro = GenerativeModel(name: "gemini-pro", apiKey: GEMINI_API_KEY)
    @State private var messageText = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "Hi! I'm your Soul Al assistant. I'm here to help you find meaningful connections. Shall we start by creating your profile?", isUser: false, timestamp: "10:30 AM")
    ]
    @State private var geminiConversationHistory: [Content] = [] // To store Gemini conversation history
//    @State private var chat: Chat?
//    // Initialize the chat when the view appears or when needed
//    mutating func initializeChat() {
//            if chat == nil {
//                let initialHistory: [ModelContent] = messages.map { chatMessage in
//                    let role: String = chatMessage.isUser ? "user" : "model"
//                    let part = ModelContent.Part.text(chatMessage.text)
//                    return ModelContent(role: role, parts: [part])
//                }
//                chat = geminiPro.startChat(history: initialHistory)
//            }
//        }

    func sendMessage() {
        if !messageText.isEmpty {
            let userMessage = ChatMessage(text: messageText, isUser: true, timestamp: getCurrentTimestamp())
            messages.append(userMessage)

//            let userPart = ModelContent.Part.text(messageText)
//            let userContent = ModelContent(role: "user", parts: [userPart])
//            chat?.history.append(userContent) // Add to the package's history
//
//            messageText = ""
//
//            Task {
//                do {
//                    guard let response = try await chat?.sendMessage(userPart) else {
//                        print("Error: No response from Gemini.")
//                        return
//                    }
//
//                    if let text = response.text {
//                        DispatchQueue.main.async {
//                            let aiChatMessage = ChatMessage(text: text, isUser: false, timestamp: getCurrentTimestamp())
//                            messages.append(aiChatMessage)
//                            let aiContent = ModelContent(role: "model", parts: [.text(text)])
//                            chat?.history.append(aiContent) // Add AI response to history
//                        }
//                    }
//                } catch {
//                    print("Error sending message: \(error)")
//                    // Handle error
//                }
//            }
        }
    }

    var body: some View {
        VStack {
            // Header
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                }
                .padding(.leading)

                HStack {
                    Image("ai")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())

                    VStack(alignment: .leading) {
                        Text("Soul Al")
                            .font(.headline)
                        Text("Online")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }
                .padding(.leading, 8)

                Spacer()
            }
            .padding(.vertical, 10)

            // Chat Messages
            ScrollViewReader { scrollView in
                ScrollView {
                    VStack {
                        ForEach(messages) { message in
                            ChatMessageView(message: message)
                        }
                    }
                    .padding()
                }
                .onChange(of: messages) { newMessages in // Changed to onChange of messages
                                    if let lastMessage = newMessages.last {
                                        scrollView.scrollTo(lastMessage.id, anchor: .bottom)
                                    }
                                }
            }

            // Input Field
            HStack {
                TextField("Message Soul Al...", text: $messageText)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                Button(action: {
                    sendMessage()
                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                messages.append(ChatMessage(text: "Yes, I'd love to create my profile!", isUser: true, timestamp: getCurrentTimestamp()))
                messages.append(ChatMessage(text: "Great! Let's start with some basics. What are your interests and hobbies?", isUser: false, timestamp: getCurrentTimestamp()))
                messages.append(ChatMessage(text: "I love photography, hiking, and trying new restaurants. I also enjoy reading science fiction and playing piano!", isUser: true, timestamp: getCurrentTimestamp()))
                messages.append(ChatMessage(text: "Those are wonderful interests! What kind of relationship are you looking for on Soul?", isUser: false, timestamp: getCurrentTimestamp()))
            }
        }
    }

    func sendMessage1() {
            if !messageText.isEmpty {
                let userMessage = ChatMessage(text: messageText, isUser: true, timestamp: getCurrentTimestamp())
                messages.append(userMessage)
                let currentInputContent = Content(role: "user", parts: [Part(text: messageText)])
                geminiConversationHistory.append(currentInputContent) // Add user message to history
                let messageToSend = messageText
                messageText = ""

                sendGeminiMessage(apiKey: GEMINI_API_KEY, conversationHistory: geminiConversationHistory) { aiResponse in
                    if let aiResponse = aiResponse {
                        DispatchQueue.main.async {
                            let aiChatMessage = ChatMessage(text: aiResponse, isUser: false, timestamp: getCurrentTimestamp())
                            messages.append(aiChatMessage)
                            let aiOutputContent = Content(role: "model", parts: [Part(text: aiResponse)])
                            geminiConversationHistory.append(aiOutputContent) // Add AI response to history
                        }
                    } else {
                        print("Gemini API call failed.")
                        // Handle error (e.g., display an error message to the user)
                    }
                }
            }
        }

        func sendGeminiMessage(apiKey: String, conversationHistory: [Content], completion: @escaping (String?) -> Void) {
            let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=\(apiKey)")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let geminiRequest = GeminiRequest(contents: conversationHistory)

            do {
                let jsonData = try JSONEncoder().encode(geminiRequest)
                request.httpBody = jsonData

                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error sending message to Gemini: \(error)")
                        completion(nil)
                        return
                    }

                    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                        print("Invalid Gemini API response: \(response!)")
                        completion(nil)
                        return
                    }

                    if let data = data {
                        do {
                            let geminiResponse = try JSONDecoder().decode(GeminiResponse.self, from: data)
                            if let aiResponse = geminiResponse.candidates?.first?.content?.parts.first?.text {
                                completion(aiResponse)
                            } else if let feedback = geminiResponse.promptFeedback {
                                print("Gemini Prompt Feedback: \(feedback)")
                                completion(nil)
                            } else {
                                print("No response from Gemini.")
                                completion(nil)
                            }
                        } catch {
                            print("Error decoding Gemini JSON: \(error)")
                            completion(nil)
                        }
                    }
                }.resume()

            } catch {
                print("Error encoding Gemini JSON request: \(error)")
                completion(nil)
            }
        }
        func getCurrentTimestamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: Date())
    }
}

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isUser: Bool
    let timestamp: String
}

struct ChatMessageView: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            } else {
                HStack(alignment: .top) {
                    Image("ai")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(message.text)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        Text(message.timestamp)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
            }
        }
    }
}

struct AIChatView_Previews: PreviewProvider {
    static var previews: some View {
        AIChatView()
    }
}

struct GeminiRequest: Encodable {
    let contents: [Content]
}
struct Part: Decodable,Encodable {
    let text: String
}

struct Content: Encodable, Decodable {
    let role: String
    let parts: [Part]
}

struct GeminiResponse: Decodable {
    let candidates: [Candidate]?
    let promptFeedback: PromptFeedback?
}

struct Candidate: Decodable {
    let content: Content?

    enum CodingKeys: String, CodingKey {
        case content
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.content = try container.decodeIfPresent(Content.self, forKey: .content)
    }
}
struct PromptFeedback: Decodable {
    // ... (details about prompt safety)
}
