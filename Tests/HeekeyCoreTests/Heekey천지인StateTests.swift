import Testing

@testable import HeekeyCore

@Suite struct Heekey천지인StateTests {
  typealias State = Heekey천지인State
  typealias Action = Heekey천지인Action

  @Test(arguments: [
    // Backspace tests
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
      State(tokens: [.자음(.ㄱ), .모음(.ㆍ)]),
      .기능(.backspace),
      ("", State(tokens: [.자음(.ㄱ)]))
    ),
    (
      State(tokens: [.자음(.ㄱ), .모음(.ㆍ), .자음(.ㄴ)]),
      .기능(.backspace),
      ("", State(tokens: [.자음(.ㄱ), .모음(.ㆍ)]))
    ),
    
    // Consonant key tests - first press
    (
      State(tokens: []),
      .조합문자(.ㄱㅋ),
      ("", State(tokens: [.자음(.ㄱ)]))
    ),
    (
      State(tokens: []),
      .조합문자(.ㄴㄹ),
      ("", State(tokens: [.자음(.ㄴ)]))
    ),
    (
      State(tokens: []),
      .조합문자(.ㄷㅌ),
      ("", State(tokens: [.자음(.ㄷ)]))
    ),
    (
      State(tokens: []),
      .조합문자(.ㅂㅍ),
      ("", State(tokens: [.자음(.ㅂ)]))
    ),
    (
      State(tokens: []),
      .조합문자(.ㅅㅎ),
      ("", State(tokens: [.자음(.ㅅ)]))
    ),
    (
      State(tokens: []),
      .조합문자(.ㅈㅊ),
      ("", State(tokens: [.자음(.ㅈ)]))
    ),
    (
      State(tokens: []),
      .조합문자(.ㅇㅁ),
      ("", State(tokens: [.자음(.ㅇ)]))
    ),
    
    // Consonant rotation tests
    // ㄱㅋㄲ rotation
    (
      State(tokens: [.자음(.ㄱ)]),
      .조합문자(.ㄱㅋ),
      ("", State(tokens: [.자음(.ㅋ)]))
    ),
    (
      State(tokens: [.자음(.ㅋ)]),
      .조합문자(.ㄱㅋ),
      ("", State(tokens: [.자음(.ㄱㄱ)]))
    ),
    (
      State(tokens: [.자음(.ㄱㄱ)]),
      .조합문자(.ㄱㅋ),
      ("", State(tokens: [.자음(.ㄱ)]))
    ),
    
    // ㄴㄹ rotation
    (
      State(tokens: [.자음(.ㄴ)]),
      .조합문자(.ㄴㄹ),
      ("", State(tokens: [.자음(.ㄹ)]))
    ),
    (
      State(tokens: [.자음(.ㄹ)]),
      .조합문자(.ㄴㄹ),
      ("", State(tokens: [.자음(.ㄴ)]))
    ),
    
    // ㄷㅌ rotation
    (
      State(tokens: [.자음(.ㄷ)]),
      .조합문자(.ㄷㅌ),
      ("", State(tokens: [.자음(.ㅌ)]))
    ),
    (
      State(tokens: [.자음(.ㅌ)]),
      .조합문자(.ㄷㅌ),
      ("", State(tokens: [.자음(.ㄸ)]))
    ),
    (
      State(tokens: [.자음(.ㄸ)]),
      .조합문자(.ㄷㅌ),
      ("", State(tokens: [.자음(.ㄷ)]))
    ),
    
    // ㅂㅍ rotation
    (
      State(tokens: [.자음(.ㅂ)]),
      .조합문자(.ㅂㅍ),
      ("", State(tokens: [.자음(.ㅍ)]))
    ),
    (
      State(tokens: [.자음(.ㅍ)]),
      .조합문자(.ㅂㅍ),
      ("", State(tokens: [.자음(.ㅃ)]))
    ),
    (
      State(tokens: [.자음(.ㅃ)]),
      .조합문자(.ㅂㅍ),
      ("", State(tokens: [.자음(.ㅂ)]))
    ),
    
    // ㅅㅎ rotation
    (
      State(tokens: [.자음(.ㅅ)]),
      .조합문자(.ㅅㅎ),
      ("", State(tokens: [.자음(.ㅎ)]))
    ),
    (
      State(tokens: [.자음(.ㅎ)]),
      .조합문자(.ㅅㅎ),
      ("", State(tokens: [.자음(.ㅆ)]))
    ),
    (
      State(tokens: [.자음(.ㅆ)]),
      .조합문자(.ㅅㅎ),
      ("", State(tokens: [.자음(.ㅅ)]))
    ),
    
    // ㅈㅊ rotation
    (
      State(tokens: [.자음(.ㅈ)]),
      .조합문자(.ㅈㅊ),
      ("", State(tokens: [.자음(.ㅊ)]))
    ),
    (
      State(tokens: [.자음(.ㅊ)]),
      .조합문자(.ㅈㅊ),
      ("", State(tokens: [.자음(.ㅈㅈ)]))
    ),
    (
      State(tokens: [.자음(.ㅈㅈ)]),
      .조합문자(.ㅈㅊ),
      ("", State(tokens: [.자음(.ㅈ)]))
    ),
    
    // ㅇㅁ rotation
    (
      State(tokens: [.자음(.ㅇ)]),
      .조합문자(.ㅇㅁ),
      ("", State(tokens: [.자음(.ㅁ)]))
    ),
    (
      State(tokens: [.자음(.ㅁ)]),
      .조합문자(.ㅇㅁ),
      ("", State(tokens: [.자음(.ㅇ)]))
    ),
    
    // Basic vowel key presses
    (
      State(tokens: []),
      .조합문자(.ㆍ),
      ("", State(tokens: [.모음(.ㆍ)]))
    ),
    (
      State(tokens: []),
      .조합문자(.ㅡ),
      ("", State(tokens: [.모음(.ㅡ)]))
    ),
    (
      State(tokens: []),
      .조합문자(.ㅣ),
      ("", State(tokens: [.모음(.ㅣ)]))
    ),
    
    // Combined initial consonant and vowel
    (
      State(tokens: [.자음(.ㄱ)]),
      .조합문자(.ㆍ),
      ("", State(tokens: [.자음(.ㄱ), .모음(.ㆍ)]))
    ),
    (
      State(tokens: [.자음(.ㄱ)]),
      .조합문자(.ㅡ),
      ("", State(tokens: [.자음(.ㄱ), .모음(.ㅡ)]))
    ),
    (
      State(tokens: [.자음(.ㄱ)]),
      .조합문자(.ㅣ),
      ("", State(tokens: [.자음(.ㄱ), .모음(.ㅣ)]))
    ),
    
    // Combined vowels - adding second vowel
    (
      State(tokens: [.모음(.ㆍ)]),
      .조합문자(.ㅡ),
      ("", State(tokens: [.모음(.ㅗ)]))
    ),
    (
      State(tokens: [.모음(.ㆍ)]),
      .조합문자(.ㅣ),
      ("", State(tokens: [.모음(.ㅏ)]))
    ),
    (
      State(tokens: [.모음(.ㅡ)]),
      .조합문자(.ㆍ),
      ("", State(tokens: [.모음(.ㅜ)]))
    ),
    (
      State(tokens: [.모음(.ㅡ)]),
      .조합문자(.ㅣ),
      ("", State(tokens: [.모음(.ㅢ)]))
    ),
    (
      State(tokens: [.모음(.ㅣ)]),
      .조합문자(.ㆍ),
      ("", State(tokens: [.모음(.ㅓ)]))
    ),
    (
      State(tokens: [.모음(.ㅣ)]),
      .조합문자(.ㅡ),
      ("", State(tokens: [.모음(.ㅠ)]))
    ),
    
    // Double same vowels
    (
      State(tokens: [.모음(.ㆍ)]),
      .조합문자(.ㆍ),
      ("", State(tokens: [.모음(.ㅛ)]))
    ),
    (
      State(tokens: [.모음(.ㅡ)]),
      .조합문자(.ㅡ),
      ("", State(tokens: [.모음(.ㅜ)]))
    ),
    (
      State(tokens: [.모음(.ㅣ)]),
      .조합문자(.ㅣ),
      ("", State(tokens: [.모음(.ㅣ)]))
    ),
    
    // Triple vowel combinations
    (
      State(tokens: [.모음(.ㅗ)]), // ㆍㅡ
      .조합문자(.ㅣ),
      ("", State(tokens: [.모음(.ㅘ)]))
    ),
    (
      State(tokens: [.모음(.ㅜ)]), // ㅡㆍ
      .조합문자(.ㅣ),
      ("", State(tokens: [.모음(.ㅝ)]))
    ),
    
    // Adding final consonant
    (
      State(tokens: [.자음(.ㄱ), .모음(.ㆍ)]),
      .조합문자(.ㄴㄹ),
      ("", State(tokens: [.자음(.ㄱ), .모음(.ㆍ), .자음(.ㄴ)]))
    ),
    
    // Adding another vowel after syllable
    (
      State(tokens: [.자음(.ㄱ), .모음(.ㆍ), .자음(.ㄴ)]),
      .조합문자(.ㅣ),
      ("가느", State(tokens: [.모음(.ㅣ)]))
    ),
    
    // Complete action
    (
      State(tokens: [.자음(.ㄱ), .모음(.ㆍ)]),
      .기능(.complete),
      ("가", State(tokens: []))
    ),
    (
      State(tokens: [.자음(.ㄱ), .모음(.ㆍ), .자음(.ㄴ)]),
      .기능(.complete),
      ("간", State(tokens: []))
    ),
    
    // Punctuation
    (
      State(tokens: []),
      .조합문자(.specialChars),
      ("", State(tokens: [.punctuations(.dot)]))
    ),
    (
      State(tokens: [.punctuations(.dot)]),
      .조합문자(.specialChars),
      ("", State(tokens: [.punctuations(.comma)]))
    ),
    (
      State(tokens: [.punctuations(.comma)]),
      .조합문자(.specialChars),
      ("", State(tokens: [.punctuations(.questionMark)]))
    ),
    (
      State(tokens: [.punctuations(.questionMark)]),
      .조합문자(.specialChars),
      ("", State(tokens: [.punctuations(.exclamationMark)]))
    ),
    (
      State(tokens: [.punctuations(.exclamationMark)]),
      .조합문자(.specialChars),
      ("", State(tokens: [.punctuations(.dot)]))
    ),
    (
      State(tokens: [.punctuations(.dot)]),
      .기능(.complete),
      (".", State(tokens: []))
    ),
    
    // Adding consonant after vowel-only state
    (
      State(tokens: [.모음(.ㆍ)]),
      .조합문자(.ㄱㅋ),
      ("ㅏ", State(tokens: [.자음(.ㄱ)]))
    ),
    
    // Adding vowel to complete syllable
    (
      State(tokens: [.자음(.ㄱ), .모음(.ㆍ), .자음(.ㄴ)]),
      .조합문자(.ㆍ),
      ("간", State(tokens: [.모음(.ㆍ)]))
    ),
  ]) func testDispatch(arg: (State, Action, (String, State))) {
    let (prev, action, (expectedEmit, expectedNext)) = arg
    let (emit, next) = prev.dispatch(action: action)
    #expect(emit == expectedEmit)
    #expect(next == expectedNext)
  }
}
