import SwiftUI

/// System Usability Scale（システムユーザビリティ尺度）の計算を行うユーティリティクラス
public struct SUSCalculator {
    
    /// SUSスコアの計算式: SUS = 2.5 * (20 + 奇数項目の合計 - 偶数項目の合計)
    /// 注：奇数項目は（回答値-1）、偶数項目は（5-回答値）で変換してから計算
    public static func calculateSUSScore(responses: [Int]) -> Double {
        guard responses.count == 10 else { return 0.0 }
        
        // 奇数項目 (1, 3, 5, 7, 9) - インデックス 0, 2, 4, 6, 8
        // 正の質問：回答値から1を引く（1-5 → 0-4）
        let oddItemsSum = (responses[0] - 1) + (responses[2] - 1) + (responses[4] - 1) + (responses[6] - 1) + (responses[8] - 1)
        
        // 偶数項目 (2, 4, 6, 8, 10) - インデックス 1, 3, 5, 7, 9  
        // 負の質問：5から回答値を引く（1-5 → 4-0）
        let evenItemsSum = (5 - responses[1]) + (5 - responses[3]) + (5 - responses[5]) + (5 - responses[7]) + (5 - responses[9])
        
        // SUS計算式
        let score = 2.5 * Double(oddItemsSum + evenItemsSum)
        
        return max(0.0, min(100.0, score)) // 0-100の範囲に制限
    }
}
