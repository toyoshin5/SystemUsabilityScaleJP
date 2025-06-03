import Testing
import Foundation
@testable import SystemUsabilityScaleJP

@Test func testSUSScoreCalculation() async throws {
    // 最高スコア（100点）の場合: [5, 1, 5, 1, 5, 1, 5, 1, 5, 1]
    let perfectResponses = [5, 1, 5, 1, 5, 1, 5, 1, 5, 1]
    let perfectScore = SUSCalculator.calculateSUSScore(responses: perfectResponses)
    #expect(perfectScore == 100.0)
    
    // 最低スコア（0点）の場合: [1, 5, 1, 5, 1, 5, 1, 5, 1, 5]
    let worstResponses = [1, 5, 1, 5, 1, 5, 1, 5, 1, 5]
    let worstScore = SUSCalculator.calculateSUSScore(responses: worstResponses)
    #expect(worstScore == 0.0)
    
    // 全て中間評価（3）の場合 - スコアは50点
    let neutralResponses = Array(repeating: 3, count: 10)
    let neutralScore = SUSCalculator.calculateSUSScore(responses: neutralResponses)
    #expect(neutralScore == 50.0)
    
    // 1231231231 の場合
    let mixedResponses = [1, 2, 3, 1, 2, 3, 1, 2, 3, 1]
    let mixedScore = SUSCalculator.calculateSUSScore(responses: mixedResponses)
    #expect(mixedScore == 52.5)
}

@Test func testSUSResultInitialization() async throws {
    let responses = [5, 1, 5, 1, 5, 1, 5, 1, 5, 1]
    let result = SUSResult(responses: responses)
    
    #expect(result.responses == responses)
    #expect(result.score == 100.0)
    #expect(result.gradeLevel == "A+ (優秀)")
}

@Test func testSUSGradeLevels() async throws {
    let testCases: [(score: Double, expectedGrade: String)] = [
        (95.0, "A+ (優秀)"),
        (85.0, "A (良好)"),
        (75.0, "B (普通)"),
        (65.0, "C (やや不良)"),
        (55.0, "D (不良)"),
        (25.0, "F (非常に不良)"),
        (10.0, "F (非常に不良)")
    ]
    
    for testCase in testCases {
        let result = SUSResult(responses: [], score: testCase.score)
        #expect(result.gradeLevel == testCase.expectedGrade)
    }
}

@MainActor @Test func testQuestionItems() async throws {
    let questions = SUSQuestionItem.standardQuestions
    
    #expect(questions.count == 10)
    
    // 奇数項目（1, 3, 5, 7, 9）は正の質問
    #expect(questions[0].isPositive == true)  // Q1
    #expect(questions[2].isPositive == true)  // Q3
    #expect(questions[4].isPositive == true)  // Q5
    #expect(questions[6].isPositive == true)  // Q7
    #expect(questions[8].isPositive == true)  // Q9
    
    // 偶数項目（2, 4, 6, 8, 10）は負の質問
    #expect(questions[1].isPositive == false) // Q2
    #expect(questions[3].isPositive == false) // Q4
    #expect(questions[5].isPositive == false) // Q6
    #expect(questions[7].isPositive == false) // Q8
    #expect(questions[9].isPositive == false) // Q10
}
