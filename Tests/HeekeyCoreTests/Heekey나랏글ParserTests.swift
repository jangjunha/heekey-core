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
        나랏글Symbol(나랏글초성.ㄱ),
        나랏글Symbol(나랏글중성.ㅢ),
      ]
    ),
  ]) func testParse모음(arg: (String, [나랏글Symbol])) {
    let (str, expected) = arg
    #expect(str_to_나랏글tokens(str).parse() == expected)
  }

  @Test(arguments: [
    (
      "ㄱㅏㄲㄱ",
      [
        나랏글Symbol(나랏글초성.ㄱ),
        나랏글Symbol(나랏글중성.ㅏ),
        나랏글Symbol(나랏글종성.ㄱㄱ),
        나랏글Symbol(나랏글초성.ㄱ),
      ]
    ),
    (
      "ㄱㅏㄸㄱ",
      [
        나랏글Symbol(나랏글초성.ㄱ),
        나랏글Symbol(나랏글중성.ㅏ),
        나랏글Symbol(나랏글초성.ㄷㄷ),
        나랏글Symbol(나랏글초성.ㄱ),
      ]
    ),
    (
      "ㄱㅏㄴㅏ",
      [
        나랏글Symbol(나랏글초성.ㄱ),
        나랏글Symbol(나랏글중성.ㅏ),
        나랏글Symbol(나랏글초성.ㄴ),
        나랏글Symbol(나랏글중성.ㅏ),
      ]
    ),
    (
      "ㄱㅏㄱㄱ",
      [
        나랏글Symbol(나랏글초성.ㄱ),
        나랏글Symbol(나랏글중성.ㅏ),
        나랏글Symbol(나랏글종성.ㄱ),
        나랏글Symbol(나랏글초성.ㄱ),
      ]
    ),  // ㄱㄱ + ? => 겹받칩 불가
    (
      "ㄱㅏㄱㅅ",
      [
        나랏글Symbol(나랏글초성.ㄱ),
        나랏글Symbol(나랏글중성.ㅏ),
        나랏글Symbol(나랏글종성.ㄱㅅ),
      ]
    ),
    (
      "ㄱㅏㄱㅅㄱ",
      [
        나랏글Symbol(나랏글초성.ㄱ),
        나랏글Symbol(나랏글중성.ㅏ),
        나랏글Symbol(나랏글종성.ㄱㅅ),
        나랏글Symbol(나랏글초성.ㄱ),
      ]
    ),  // ㄱㅅ + 자음 => 겹받침 완성
    (
      "ㄱㅏㄱㅅㅏ",
      [
        나랏글Symbol(나랏글초성.ㄱ),
        나랏글Symbol(나랏글중성.ㅏ),
        나랏글Symbol(나랏글종성.ㄱ),
        나랏글Symbol(나랏글초성.ㅅ),
        나랏글Symbol(나랏글중성.ㅏ),
      ]
    ),  // ㄱㅅ + 모음 => 겹받침 안함
  ]) func testParse받침(arg: (String, [나랏글Symbol])) {
    let (str, expected) = arg
    #expect(str_to_나랏글tokens(str).parse() == expected)
  }
}
