import Testing

@testable import HeekeyCore

@Suite struct Heekey나랏글StateTests {
  typealias State = Heekey나랏글State
  typealias Action = Heekey나랏글Action

  @Test(arguments: [
    (
      State(tokens: []),
      Action.기능(.backspace),
      ("", State(tokens: [])) as (String, State)
    ),
    (
      State(tokens: [.자음(.ㄱ)]),
      .기능(.backspace),
      ("", State(tokens: []))
    ),
    (
      State(tokens: [.자음(.ㄱ), .모음(.ㅏ)]),
      .기능(.backspace),
      ("", State(tokens: [.자음(.ㄱ)]))
    ),
    (
      State(tokens: [.자음(.ㄱ)]),
      .완성문자("."),
      ("ㄱ.", State(tokens: []))
    ),
    (
      State(tokens: [.자음(.ㄱ), .모음(.ㅏ)]),
      .완성문자("."),
      ("가.", State(tokens: []))
    ),
    (
      State(tokens: [.모음(.ㅏ)]),
      .완성문자("."),
      ("ㅏ.", State(tokens: []))
    ),
    (
      State(tokens: []),
      .완성문자("."),
      (".", State(tokens: []))
    ),
    (
      State(tokens: []),
      .조합문자(.ㄱ),
      ("", State(tokens: [.자음(.ㄱ)]))
    ),
    (
      State(tokens: []),
      .조합문자(.ㅏㅓ),
      ("", State(tokens: [.모음(.ㅏ)]))
    ),
    (
      State(tokens: [.자음(.ㄱ)]),
      .조합문자(.ㄱ),
      ("", State(tokens: [.자음(.ㄱ), .자음(.ㄱ)]))
    ),
    (
      State(tokens: [.자음(.ㄱ)]),
      .조합문자(.ㅏㅓ),
      ("", State(tokens: [.자음(.ㄱ), .모음(.ㅏ)]))
    ),
    (
      State(tokens: [.자음(.ㄱ)]),
      .기능(.쌍자음),
      ("", State(tokens: [.자음(.ㄱㄱ)]))
    ),
    (
      State(tokens: [.자음(.ㄴ)]),
      .기능(.쌍자음),
      ("", State(tokens: [.자음(.ㄴ)]))
    ),
    (
      State(tokens: [.자음(.ㄱ)]),
      .기능(.획추가),
      ("", State(tokens: [.자음(.ㅋ)]))
    ),
    (
      State(tokens: [.자음(.ㅋ)]),
      .기능(.획추가),
      ("", State(tokens: [.자음(.ㄱ)]))
    ),
    (
      State(tokens: [.자음(.ㄹ)]),
      .기능(.획추가),
      ("", State(tokens: [.자음(.ㄹ)]))
    ),
    (
      State(tokens: [.모음(.ㅏ)]),
      .조합문자(.ㅏㅓ),
      ("", State(tokens: [.모음(.ㅓ)]))
    ),
    (
      State(tokens: [.모음(.ㅓ)]),
      .조합문자(.ㅏㅓ),
      ("", State(tokens: [.모음(.ㅏ)]))
    ),
    (
      State(tokens: [.모음(.ㅗ)]),
      .조합문자(.ㅗㅜ),
      ("", State(tokens: [.모음(.ㅜ)]))
    ),
    (
      State(tokens: [.모음(.ㅜ)]),
      .조합문자(.ㅗㅜ),
      ("", State(tokens: [.모음(.ㅗ)]))
    ),
    (
      State(tokens: [.모음(.ㅜ)]),
      .조합문자(.ㅏㅓ),
      ("", State(tokens: [.모음(.ㅜ), .모음(.ㅓ)]))
    ),
    (
      State(tokens: [.모음(.ㅗ)]),
      .조합문자(.ㅏㅓ),
      ("", State(tokens: [.모음(.ㅗ), .모음(.ㅏ)]))
    ),
    (
      State(tokens: [.모음(.ㅏ)]),
      .기능(.쌍자음),
      ("", State(tokens: [.모음(.ㅏ)]))
    ),
    (
      State(tokens: [.모음(.ㅏ)]),
      .기능(.획추가),
      ("", State(tokens: [.모음(.ㅑ)]))
    ),
    (
      State(tokens: [.모음(.ㅑ)]),
      .기능(.획추가),
      ("", State(tokens: [.모음(.ㅑ)]))
    ),
    (
      State(tokens: [.모음(.ㅓ)]),
      .기능(.획추가),
      ("", State(tokens: [.모음(.ㅕ)]))
    ),
    (
      State(tokens: [.모음(.ㅗ)]),
      .기능(.획추가),
      ("", State(tokens: [.모음(.ㅛ)]))
    ),
    (
      State(tokens: [.모음(.ㅜ)]),
      .기능(.획추가),
      ("", State(tokens: [.모음(.ㅠ)]))
    ),
    (
      State(tokens: [.모음(.ㅡ)]),
      .기능(.획추가),
      ("", State(tokens: [.모음(.ㅡ)]))
    ),
  ]) func testReduce(arg: (Heekey나랏글State, Heekey나랏글Action, (String, Heekey나랏글State))) {
    let (prev, action, (expectedEmit, expectedNext)) = arg
    let (emit, next) = prev.dispatch(action: action)
    #expect(emit == expectedEmit)
    #expect(next == expectedNext)
  }
}
