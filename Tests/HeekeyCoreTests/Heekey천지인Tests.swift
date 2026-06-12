import Testing

@testable import HeekeyCore

@Suite struct Heekey천지인Tests {
  typealias State = Heekey천지인State
  typealias Action = Heekey천지인Action

  /// 키 입력 시퀀스를 순서대로 적용하고 최종 표시 문자열을 반환합니다.
  private func type(_ actions: [Action]) -> String {
    var state = State(tokens: [])
    var emitted = ""
    for action in actions {
      let (str, next) = state.dispatch(action: action)
      emitted += str
      state = next
    }
    return emitted + state.string
  }

  // MARK: 모음 조합

  @Test(arguments: [
    ([.ㅣ], "ㅣ"),
    ([.ㅡ], "ㅡ"),
    ([.천], "ㆍ"),
    ([.천, .천], "‥"),
    ([.ㅣ, .천], "ㅏ"),
    ([.ㅣ, .천, .ㅣ], "ㅐ"),
    ([.ㅣ, .천, .천], "ㅑ"),
    ([.ㅣ, .천, .천, .ㅣ], "ㅒ"),
    ([.천, .ㅣ], "ㅓ"),
    ([.천, .ㅣ, .ㅣ], "ㅔ"),
    ([.천, .천, .ㅣ], "ㅕ"),
    ([.천, .천, .ㅣ, .ㅣ], "ㅖ"),
    ([.천, .ㅡ], "ㅗ"),
    ([.천, .ㅡ, .ㅣ], "ㅚ"),
    ([.천, .ㅡ, .ㅣ, .천], "ㅘ"),
    ([.천, .ㅡ, .ㅣ, .천, .ㅣ], "ㅙ"),
    ([.천, .천, .ㅡ], "ㅛ"),
    ([.ㅡ, .천], "ㅜ"),
    ([.ㅡ, .천, .ㅣ], "ㅟ"),
    ([.ㅡ, .천, .천], "ㅠ"),
    ([.ㅡ, .천, .천, .ㅣ], "ㅝ"),
    ([.ㅡ, .천, .천, .ㅣ, .ㅣ], "ㅞ"),
    ([.ㅡ, .ㅣ], "ㅢ"),
  ] as [([Heekey천지인조합문자], String)])
  func test모음조합(arg: ([Heekey천지인조합문자], String)) {
    let (keys, expected) = arg
    #expect(type(keys.map { .조합문자($0, 연속입력: false) }) == expected)
  }

  // MARK: 자음 멀티탭

  @Test func test자음순환() {
    let ㄱ = Action.조합문자(.ㄱㅋ, 연속입력: false)
    let ㄱ연속 = Action.조합문자(.ㄱㅋ, 연속입력: true)
    #expect(type([ㄱ]) == "ㄱ")
    #expect(type([ㄱ, ㄱ연속]) == "ㅋ")
    #expect(type([ㄱ, ㄱ연속, ㄱ연속]) == "ㄲ")
    #expect(type([ㄱ, ㄱ연속, ㄱ연속, ㄱ연속]) == "ㄱ")
    // 연속입력이 아니면 순환하지 않고 새 자음
    #expect(type([ㄱ, ㄱ]) == "ㄱㄱ")
  }

  @Test func test자음순환_2단계() {
    let ㄴ = Action.조합문자(.ㄴㄹ, 연속입력: false)
    let ㄴ연속 = Action.조합문자(.ㄴㄹ, 연속입력: true)
    #expect(type([ㄴ]) == "ㄴ")
    #expect(type([ㄴ, ㄴ연속]) == "ㄹ")
    #expect(type([ㄴ, ㄴ연속, ㄴ연속]) == "ㄴ")
  }

  // MARK: 음절 시나리오

  private func 가(_ keys: [Heekey천지인조합문자]) -> [Action] {
    keys.map { .조합문자($0, 연속입력: false) }
  }

  @Test func test기본음절() {
    // 가: ㄱ ㅣ ㆍ
    #expect(type(가([.ㄱㅋ, .ㅣ, .천])) == "가")
    // 한: ㅅㅎ×2(ㅎ) ㅣㆍ(ㅏ) ㄴ
    #expect(
      type([
        .조합문자(.ㅅㅎ, 연속입력: false), .조합문자(.ㅅㅎ, 연속입력: true),
        .조합문자(.ㅣ, 연속입력: false), .조합문자(.천, 연속입력: false),
        .조합문자(.ㄴㄹ, 연속입력: false),
      ]) == "한")
  }

  @Test func test받침과겹받침() {
    // 값: ㄱ ㅏ ㅂ ㅅ
    #expect(type(가([.ㄱㅋ, .ㅣ, .천, .ㅂㅍ, .ㅅㅎ])) == "값")
    // 앉: ㅇ ㅏ ㄴ ㅈ
    #expect(type(가([.ㅇㅁ, .ㅣ, .천, .ㄴㄹ, .ㅈㅊ])) == "앉")
    // 앉 + ㅏ → 안자
    #expect(type(가([.ㅇㅁ, .ㅣ, .천, .ㄴㄹ, .ㅈㅊ, .ㅣ, .천])) == "안자")
  }

  @Test func test받침이동() {
    // 각 + ㅣ → 가기
    #expect(type(가([.ㄱㅋ, .ㅣ, .천, .ㄱㅋ])) == "각")
    #expect(type(가([.ㄱㅋ, .ㅣ, .천, .ㄱㅋ, .ㅣ])) == "가기")
  }

  @Test func test멀티탭과받침() {
    // 악 + ㄱ(연속) → 앜
    let 악 = 가([.ㅇㅁ, .ㅣ, .천, .ㄱㅋ])
    #expect(type(악) == "악")
    #expect(type(악 + [.조합문자(.ㄱㅋ, 연속입력: true)]) == "앜")
    // 악 + ㄱ(새 입력) → 악ㄱ
    #expect(type(악 + [.조합문자(.ㄱㅋ, 연속입력: false)]) == "악ㄱ")
  }

  @Test func test조합중간상태표시() {
    // 갸 도중: ㄱㆍ 표시
    #expect(type(가([.ㄱㅋ, .천])) == "ㄱㆍ")
    // ㅑ 조합 도중 ㆍㆍ 표시
    #expect(type(가([.ㄱㅋ, .ㅣ, .천, .천])) == "갸")
    #expect(type(가([.ㅇㅁ, .천, .천])) == "ㅇ‥")
  }

  @Test func test천순환() {
    // 갸(ㅣㆍㆍ) + ㆍ → 가(ㅣㆍ)
    #expect(type(가([.ㄱㅋ, .ㅣ, .천, .천, .천])) == "가")
    // ㅠ(ㅡㆍㆍ) + ㆍ → ㅜ(ㅡㆍ)
    #expect(type(가([.ㅡ, .천, .천, .천])) == "ㅜ")
  }

  @Test func test백스페이스() {
    // 가 → (bs) → 기
    #expect(type(가([.ㄱㅋ, .ㅣ, .천]) + [.기능(.backspace)]) == "기")
    // 값 → (bs) → 갑
    #expect(type(가([.ㄱㅋ, .ㅣ, .천, .ㅂㅍ, .ㅅㅎ]) + [.기능(.backspace)]) == "갑")
  }

  @Test func test다음절() {
    // 나라: ㄴ ㅣㆍ ㄴㄹ(연속 아님→ㄴ?) — 라는 fresh ㄴㄹ 두 번이 아니라 fresh+연속이 아닌 새 키 입력으로 ㄹ을 만들 수 없으므로
    // 노래: ㄴ ㆍㅡ(ㅗ) ㄴㄹ ㄹ(연속) ㅣㆍ(ㅏ) ㅣ(→ㅐ)
    #expect(
      type([
        .조합문자(.ㄴㄹ, 연속입력: false),
        .조합문자(.천, 연속입력: false), .조합문자(.ㅡ, 연속입력: false),
        .조합문자(.ㄴㄹ, 연속입력: false), .조합문자(.ㄴㄹ, 연속입력: true),
        .조합문자(.ㅣ, 연속입력: false), .조합문자(.천, 연속입력: false),
        .조합문자(.ㅣ, 연속입력: false),
      ]) == "노래")
  }

  @Test func test완성문자() {
    #expect(type(가([.ㄱㅋ, .ㅣ, .천]) + [.완성문자("!")]) == "가!")
  }

  // MARK: 불변식

  static let invariantActions: [Action] = [
    .조합문자(.ㄱㅋ, 연속입력: false), .조합문자(.ㄴㄹ, 연속입력: false),
    .조합문자(.ㅅㅎ, 연속입력: false), .조합문자(.ㅇㅁ, 연속입력: false),
    .조합문자(.ㄱㅋ, 연속입력: true), .조합문자(.ㅅㅎ, 연속입력: true),
    .조합문자(.ㅣ, 연속입력: false), .조합문자(.천, 연속입력: false), .조합문자(.ㅡ, 연속입력: false),
    .기능(.backspace),
  ]

  /// 어떤 키를 누르더라도 마지막 두 글자 이전은 변하지 않아야 한다.
  /// 단 backspace는 ㆍ 삭제로 마지막 세 글자가 병합될 수 있다 (예: "기ㄱㆍ" → "긱").
  @Test func testStablePrefixInvariant() {
    var seen = Set<[Heekey천지인Token]>()
    var frontier: [State] = [.init(tokens: [])]
    seen.insert([])
    var violations: [String] = []

    for _ in 0..<5 {
      var next: [State] = []
      for state in frontier {
        let cur = state.string
        for action in Self.invariantActions {
          let (emit, nextState) = state.dispatch(action: action)
          let result = emit + nextState.string
          let window = action == .기능(.backspace) ? 3 : 2
          let stablePrefix = String(cur.dropLast(window))
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
