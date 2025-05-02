import Testing

@testable import HeekeyCore

// 초성
// ᄀ ᄁ ᄂ ᄃ ᄄ ᄅ ᄆ ᄇ ᄈ ᄉ ᄊ ᄋ ᄌ ᄍ ᄎ ᄏ ᄐ ᄑ ᄒ.
// 중성
// ᅡ ᅢ ᅣ ᅤ ᅥ ᅦ ᅧ ᅨ ᅩ ᅪ ᅫ ᅬ ᅭ ᅮ ᅯ ᅰ ᅱ ᅲ ᅳ ᅴ ᅵ.
// 종성
// ᆨ ᆩ ᆪ ᆫ ᆬ ᆭ ᆮ ᆯ ᆰ ᆱ ᆲ ᆳ ᆴ ᆵ ᆶ ᆷ ᆸ ᆹ ᆺ ᆻ ᆼ ᆽ ᆾ ᆿ ᇀ ᇁ ᇂ

@Suite struct ParserTests {
  @Test func testTokensToString() {
    #expect(str_to_tokens("ㅁㅁㅁ").string == "ㅁㅁㅁ")
  }

  @Test(arguments: [
    (
      "ㄱㅏㄲㄱ",
      [
        Symbol(초성.ㄱ),
        Symbol(중성.ㅏ),
        Symbol(종성.ㄱㄱ),
        Symbol(초성.ㄱ),
      ]
    ),
    (
      "ㄱㅏㄸㄱ",
      [
        Symbol(초성.ㄱ),
        Symbol(중성.ㅏ),
        Symbol(초성.ㄷㄷ),
        Symbol(초성.ㄱ),
      ]
    ),
    (
      "ㄱㅏㄴㅏ",
      [
        Symbol(초성.ㄱ),
        Symbol(중성.ㅏ),
        Symbol(초성.ㄴ),
        Symbol(중성.ㅏ),
      ]
    ),
    (
      "ㄱㅏㄱㄱ",
      [
        Symbol(초성.ㄱ),
        Symbol(중성.ㅏ),
        Symbol(종성.ㄱ),
        Symbol(초성.ㄱ),
      ]
    ),  // ㄱㄱ + ? => 겹받칩 불가
    (
      "ㄱㅏㄱㅅ",
      [
        Symbol(초성.ㄱ),
        Symbol(중성.ㅏ),
        Symbol(종성.ㄱㅅ),
      ]
    ),
    (
      "ㄱㅏㄱㅅㄱ",
      [
        Symbol(초성.ㄱ),
        Symbol(중성.ㅏ),
        Symbol(종성.ㄱㅅ),
        Symbol(초성.ㄱ),
      ]
    ),  // ㄱㅅ + 자음 => 겹받침 완성
    (
      "ㄱㅏㄱㅅㅏ",
      [
        Symbol(초성.ㄱ),
        Symbol(중성.ㅏ),
        Symbol(종성.ㄱ),
        Symbol(초성.ㅅ),
        Symbol(중성.ㅏ),
      ]
    ),  // ㄱㅅ + 모음 => 겹받침 안함
  ]) func testParse(arg: (String, [Symbol])) {
    let (str, expected) = arg
    #expect(str_to_tokens(str).parse() == expected)
  }
}
