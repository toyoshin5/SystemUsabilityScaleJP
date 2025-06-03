import Foundation

/// SUSの質問項目を表すモデル
public struct SUSQuestionItem: Identifiable {
    public let id: Int
    public let question: String
    public let isPositive: Bool // 正の質問かどうか（奇数項目は正、偶数項目は負）
    
    public init(id: Int, question: String, isPositive: Bool) {
        self.id = id
        self.question = question
        self.isPositive = isPositive
    }
}

/// 標準のSUS質問項目（日本語版）
public extension SUSQuestionItem {
    @MainActor static let standardQuestions: [SUSQuestionItem] = [
        SUSQuestionItem(
            id: 1,
            question: "このシステムを頻繁に使いたいと思う",
            isPositive: true
        ),
        SUSQuestionItem(
            id: 2,
            question: "このシステムは不必要に複雑だと思う",
            isPositive: false
        ),
        SUSQuestionItem(
            id: 3,
            question: "このシステムは使いやすいと思う",
            isPositive: true
        ),
        SUSQuestionItem(
            id: 4,
            question: "このシステムを使うには技術サポートが必要だと思う",
            isPositive: false
        ),
        SUSQuestionItem(
            id: 5,
            question: "このシステムの様々な機能はよく統合されていると思う",
            isPositive: true
        ),
        SUSQuestionItem(
            id: 6,
            question: "このシステムには矛盾が多すぎると思う",
            isPositive: false
        ),
        SUSQuestionItem(
            id: 7,
            question: "ほとんどの人がこのシステムの使い方をすぐに覚えられると思う",
            isPositive: true
        ),
        SUSQuestionItem(
            id: 8,
            question: "このシステムは非常に使いにくいと思う",
            isPositive: false
        ),
        SUSQuestionItem(
            id: 9,
            question: "このシステムを使っていて自信を持てた",
            isPositive: true
        ),
        SUSQuestionItem(
            id: 10,
            question: "このシステムを使い始める前に多くのことを学ぶ必要があった",
            isPositive: false
        )
    ]
}
