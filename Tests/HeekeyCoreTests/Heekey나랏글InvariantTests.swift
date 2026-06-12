import Testing

@testable import HeekeyCore

/// 도달 가능한 모든 상태를 너비 우선으로 탐색하며 조합 불변식을 검증합니다.
///
/// 불변식: 어떤 키를 누르더라도 표시 문자열의 마지막 두 글자 이전 부분은 변하지
/// 않아야 합니다. (마지막 두 글자는 겹받침 완성 등으로 병합될 수 있습니다.
/// 예: "안ㅅ" + 획추가 → "앉")
///
/// 이 불변식이 깨지면 이미 완성된 앞 글자가 지워지거나 변형되는 버그입니다.
@Suite struct Heekey나랏글InvariantTests {
  static let actions: [Heekey나랏글Action] = [
    .조합문자(.ㄱ), .조합문자(.ㄴ), .조합문자(.ㄹ), .조합문자(.ㅁ), .조합문자(.ㅅ), .조합문자(.ㅇ),
    .조합문자(.ㅏㅓ), .조합문자(.ㅗㅜ), .조합문자(.ㅡ), .조합문자(.ㅣ),
    .기능(.획추가), .기능(.쌍자음), .기능(.backspace),
  ]

  @Test func testStablePrefixInvariant() {
    var seen = Set<[Heekey나랏글Token]>()
    var frontier: [Heekey나랏글State] = [.init(tokens: [])]
    seen.insert([])
    var violations: [String] = []

    for _ in 0..<5 {
      var next: [Heekey나랏글State] = []
      for state in frontier {
        let cur = state.string
        for action in Self.actions {
          let (emit, nextState) = state.dispatch(action: action)
          let result = emit + nextState.string
          let stablePrefix = String(cur.dropLast(2))
          if !result.hasPrefix(stablePrefix) {
            violations.append("tokens=\(state.tokens) action=\(action): \"\(cur)\" → \"\(result)\"")
          }
          if seen.insert(nextState.tokens).inserted {
            next.append(nextState)
          }
        }
      }
      frontier = next
    }
    #expect(violations.isEmpty, "\(violations.prefix(20))")
  }
}
