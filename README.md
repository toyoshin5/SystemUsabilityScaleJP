# SystemUsabilityScaleJP

HCI研究で広く使用されるSystem Usability Scale (SUS)を実施するライブラリです。

<img width="218" alt=" 2025-06-03 19 11 16" src="https://github.com/user-attachments/assets/0dfe999e-7be5-449b-9766-f135dcbc8e32" />


## 概要

System Usability Scale (SUS)は、システムのユーザビリティを測定するための標準的なアンケート手法です。10の質問項目に対して1-5段階で評価を行い、0-100点のスコアを算出します。

## 特徴

- ✅ 標準的なSUS 10項目の質問（日本語版）
- ✅ 自動的なSUSスコア計算
- ✅ グレード評価（A+〜F）
- ✅ カスタム質問項目対応

## インストール

### Swift Package Manager

Xcodeで以下の手順でインストールできます：

1. File → Add Package Dependencies...
2. URLに `https://github.com/toyoshin5/SystemUsabilityScaleJP` を入力
3. Add Package をクリック

または、Package.swiftに以下を追加：

```swift
dependencies: [
    .package(url: "https://github.com/toyoshin5/SystemUsabilityScaleJP", from: "0.1.0")
]
```

## 使用方法

### 基本的な使用例

```swift
import SwiftUI
import SystemUsabilityScaleJP

struct ContentView: View {
    @State private var showingSUS = false
    
    var body: some View {
        VStack {
            Button("SUSアンケート開始") {
                showingSUS = true
            }
        }
        .sheet(isPresented: $showingSUS) {
            SystemUsabilityScaleView(
                title: "ユーザビリティ評価",
                questions: SUSQuestionItem.defaultQuestions
            ) { result in
                print("SUSスコア: \(result.score)")
                print("グレード: \(result.gradeLevel)")
                print("回答詳細: \(result.responses)")
                showingSUS = false
            }
        }
    }
}
```

### 結果の活用

```swift
SystemUsabilityScaleView(
    title: "システム評価",
    questions: SUSQuestionItem.defaultQuestions
) { result in
    // SUSスコア（0-100）
    let score = result.score
    
    // 各質問への回答（1-5の配列）
    let responses = result.responses
    
    // グレード評価
    let grade = result.gradeLevel // "A+ (優秀)", "B (普通)" など
    
    // 完了日時
    let completedAt = result.completedAt
}
```

### グレード評価(目安)

| スコア | グレード |
|--------|----------|
| 90-100 | A+ (優秀) |
| 80-89  | A (良好)  |
| 70-79  | B (普通)  |
| 60-69  | C (やや不良) |
| 50-59  | D (不良)  |
| 0-49   | F (非常に不良) |

## カスタマイズ

### カスタム質問項目

```swift
let customQuestions = [
    SUSQuestionItem(id: 1, question: "このシステムを頻繁に使いたいと思う", isPositive: true),
    SUSQuestionItem(id: 2, question: "このシステムは不必要に複雑だと思う", isPositive: false),
    // ... 全10項目を定義
]

SystemUsabilityScaleView(
    title: "カスタム評価",
    questions: customQuestions
) { result in
    // 結果処理
}
```

### 標準質問項目の使用

標準的なSUS質問項目はデフォルトで提供されています：

```swift
// 標準の10項目を使用
SystemUsabilityScaleView(
    title: "標準SUS評価",
    questions: SUSQuestionItem.defaultQuestions
) { result in
    // 結果処理
}
```

### 進捗表示のカスタマイズ

進捗表示は自動的に有効になり、現在の質問番号と全体の進捗が表示されます。UIは円形のボタンインターフェースで直感的な操作が可能です。

## API リファレンス

### SystemUsabilityScaleView

メインのSwiftUIビューコンポーネントです。

```swift
SystemUsabilityScaleView(
    title: String = "System Usability Scale",
    questions: [SUSQuestionItem] = SUSQuestionItem.defaultQuestions,
    onCompletion: @escaping (SUSResult) -> Void
)
```

#### パラメータ

- `title`: アンケートのタイトル（デフォルト: "System Usability Scale"）
- `questions`: 質問項目の配列（デフォルト: 標準SUS 10項目）
- `onCompletion`: 完了時のコールバック

### SUSResult

アンケート結果を表すデータ構造です。

```swift
struct SUSResult {
    let responses: [Int]        // 1-5の回答配列
    let score: Double          // 0-100のSUSスコア
    let completedAt: Date      // 完了日時
    var gradeLevel: String     // グレード評価文字列
}
```

### SUSQuestionItem

質問項目を表すデータ構造です。

```swift
struct SUSQuestionItem {
    let id: Int            // 質問ID
    let question: String   // 質問文
    let isPositive: Bool   // 肯定的質問かどうか
}
```

## 要件

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## トラブルシューティング

### よくある問題

**Q: スコアが期待した値にならない**
A: SUSスコアは標準的な計算式に基づいています。肯定的質問（1,3,5,7,9番）と否定的質問（2,4,6,8,10番）で計算方法が異なります。

**Q: カスタム質問でエラーが発生する**
A: 質問は必ず10項目である必要があります。また、`isPositive`フラグを適切に設定してください。

## SUS スコア計算方法

SUSスコアは以下の計算式で算出されます：

1. 奇数番号の質問（肯定的）: 回答値 - 1
2. 偶数番号の質問（否定的）: 5 - 回答値
3. 全ての調整値を合計し、2.5を掛ける

最終スコアは0-100の範囲になります。

## ライセンス

MIT License
