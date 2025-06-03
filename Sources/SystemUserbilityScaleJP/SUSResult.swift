import Foundation

/// SUSアンケートの結果を表すモデル
public struct SUSResult: Sendable {
    /// 各質問への回答（1-5の配列、10個）
    public let responses: [Int]
    
    /// 計算されたSUSスコア（0-100）
    public let score: Double
    
    /// 回答が完了した日時
    public let completedAt: Date
    
    /// カスタム初期化
    public init(responses: [Int], score: Double, completedAt: Date = Date()) {
        self.responses = responses
        self.score = score
        self.completedAt = completedAt
    }
    
    /// 回答から自動的にスコアを計算して初期化
    public init(responses: [Int], completedAt: Date = Date()) {
        self.responses = responses
        self.score = SUSCalculator.calculateSUSScore(responses: responses)
        self.completedAt = completedAt
    }
    
    /// スコアに基づく評価レベル
    public var gradeLevel: String {
        switch score {
        case 90...100:
            return "A+ (優秀)"
        case 80..<90:
            return "A (良好)"
        case 70..<80:
            return "B (普通)"
        case 60..<70:
            return "C (やや不良)"
        case 50..<60:
            return "D (不良)"
        default:
            return "F (非常に不良)"
        }
    }
}
