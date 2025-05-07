import Testing

@testable import HeekeyCore

// 초성
// ᄀ ᄁ ᄂ ᄃ ᄄ ᄅ ᄆ ᄇ ᄈ ᄉ ᄊ ᄋ ᄌ ᄍ ᄎ ᄏ ᄐ ᄑ ᄒ.
// 중성
// ᅡ ᅢ ᅣ ᅤ ᅥ ᅦ ᅧ ᅨ ᅩ ᅪ ᅫ ᅬ ᅭ ᅮ ᅯ ᅰ ᅱ ᅲ ᅳ ᅴ ᅵ.
// 종성
// ᆨ ᆩ ᆪ ᆫ ᆬ ᆭ ᆮ ᆯ ᆰ ᆱ ᆲ ᆳ ᆴ ᆵ ᆶ ᆷ ᆸ ᆹ ᆺ ᆻ ᆼ ᆽ ᆾ ᆿ ᇀ ᇁ ᇂ

@Suite struct Heekey나랏글ParserTests {
  @Test(arguments: [
    (
      "ㄱㅡㅣ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅢ),
      ]
    ),
  ]) func testParse모음(arg: (String, [Symbol])) {
    let (str, expected) = arg
    #expect(str_to_나랏글tokens(str).parse() == expected)
  }

  @Test(arguments: [
    (
      "ㄱㅏㄲㄱ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(종성Symbol.ㄱㄱ),
        Symbol(초성Symbol.ㄱ),
      ]
    ),
    (
      "ㄱㅏㄸㄱ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(초성Symbol.ㄷㄷ),
        Symbol(초성Symbol.ㄱ),
      ]
    ),
    (
      "ㄱㅏㄴㅏ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(초성Symbol.ㄴ),
        Symbol(중성Symbol.ㅏ),
      ]
    ),
    (
      "ㄱㅏㄱㄱ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(종성Symbol.ㄱ),
        Symbol(초성Symbol.ㄱ),
      ]
    ),  // ㄱㄱ + ? => 겹받칩 불가
    (
      "ㄱㅏㄱㅅ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(종성Symbol.ㄱㅅ),
      ]
    ),
    (
      "ㄱㅏㄱㅅㄱ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(종성Symbol.ㄱㅅ),
        Symbol(초성Symbol.ㄱ),
      ]
    ),  // ㄱㅅ + 자음 => 겹받침 완성
    (
      "ㄱㅏㄱㅅㅏ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(종성Symbol.ㄱ),
        Symbol(초성Symbol.ㅅ),
        Symbol(중성Symbol.ㅏ),
      ]
    ),  // ㄱㅅ + 모음 => 겹받침 안함
  ]) func testParse받침(arg: (String, [Symbol])) {
    let (str, expected) = arg
    #expect(str_to_나랏글tokens(str).parse() == expected)
  }
}
