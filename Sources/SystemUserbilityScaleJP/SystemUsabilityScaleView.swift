import SwiftUI

/// System Usability Scale アンケートのメインView
public struct SystemUsabilityScaleView: View {
    
    // MARK: - Properties
    private let title: String
    private let questions: [SUSQuestionItem]
    private let onCompletion: (SUSResult) -> Void
    
    @State private var responses: [Int?] = Array(repeating: nil, count: 10)
    
    // MARK: - Initialization
    public init(
        title: String = "SUSアンケート",
        questions: [SUSQuestionItem] = SUSQuestionItem.standardQuestions,
        onCompletion: @escaping (SUSResult) -> Void
    ) {
        self.title = title
        self.questions = questions
        self.onCompletion = onCompletion
    }
    
    // MARK: - Computed Properties
    private var isAllAnswered: Bool {
        responses.allSatisfy { $0 != nil }
    }
    
    private var answeredCount: Int {
        responses.compactMap { $0 }.count
    }
    
    // MARK: - Body
    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                headerView
                
                ForEach(Array(questions.enumerated()), id: \.offset) { index, question in
                    questionView(for: question, at: index)
                }
                
                submitButton
            }
            .padding()
        }
    }
    
    // MARK: - View Components
    
    private var headerView: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 8)
            
            Text("各項目について、あなたの同意度を5段階で評価してください")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            HStack {
                Text("進捗: \(answeredCount)/10")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                ProgressView(value: Double(answeredCount), total: 10.0)
                    .frame(width: 100)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
    
    private func questionView(for question: SUSQuestionItem, at index: Int) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Q\(question.id). \(question.question)")
                .font(.body)
                .fontWeight(.medium)
                .multilineTextAlignment(.leading)
            
            ratingScaleView(for: index)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.3), radius: 2, x: 0, y: 1)
    }
    
    private func ratingScaleView(for questionIndex: Int) -> some View {
        VStack(spacing: 12) {
            HStack {
                Text("全く同意しない")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("強く同意する")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 0) {
                ForEach(1...5, id: \.self) { rating in
                    Button(action: {
                        responses[questionIndex] = rating
                    }) {
                        VStack(spacing: 4) {
                            Circle()
                                .fill(responses[questionIndex] == rating ? Color.blue : Color.gray.opacity(0.3))
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Circle()
                                        .stroke(Color.blue, lineWidth: responses[questionIndex] == rating ? 2 : 0)
                                )
                            
                            Text("\(rating)")
                                .font(.caption)
                                .fontWeight(responses[questionIndex] == rating ? .bold : .regular)
                                .foregroundColor(responses[questionIndex] == rating ? .blue : .secondary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
    
    private var submitButton: some View {
        Button(action: calculateAndReturnResult) {
            HStack {
                Image(systemName: "checkmark.circle")
                Text("結果を表示")
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(isAllAnswered ? Color.blue : Color.gray)
            .cornerRadius(12)
        }
        .disabled(!isAllAnswered)
    }
    
    // MARK: - Actions
    
    private func calculateAndReturnResult() {
        guard isAllAnswered else { return }
        
        let finalResponses = responses.compactMap { $0 }
        let result = SUSResult(responses: finalResponses)
        
        onCompletion(result)
    }
}

// MARK: - Preview

#Preview {
    SystemUsabilityScaleView { result in
        print("SUSスコア: \(result.score)")
        print("回答: \(result.responses)")
    }
}
