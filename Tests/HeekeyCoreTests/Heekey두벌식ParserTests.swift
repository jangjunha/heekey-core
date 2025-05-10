import Testing

@testable import HeekeyCore

@Suite struct Heekey두벌식ParserTests {
  @Test(arguments: [
    (
      "ㄱㅏㅣ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(중성Symbol.ㅣ),
      ]
    ),
    (
      "ㄱㅡㅣ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅢ),
      ]
    ),
    (
      "ㄱㅏ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
      ]
    ),
    (
      "ㅎㅐㄱㅣㅗ",
      [
        Symbol(초성Symbol.ㅎ),
        Symbol(중성Symbol.ㅐ),
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅣ),
        Symbol(중성Symbol.ㅗ),
      ]
    ),
  ]) func testParse모음(arg: (String, [Symbol])) {
    let (str, expected) = arg
    #expect(str_to_두벌식tokens(str).parse() == expected)
  }
  
  @Test(arguments: [
    (
      "ㄱㅏㄴ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(종성Symbol.ㄴ),
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
    ),
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
      "ㄱㅏㄸㄱ",  // ㄷㄷ cannot be 종성
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
  ]) func testParse기본받침(arg: (String, [Symbol])) {
    let (str, expected) = arg
    #expect(str_to_두벌식tokens(str).parse() == expected)
  }
  
  @Test(arguments: [
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
    (
      "ㄱㅏㄴㅈ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(종성Symbol.ㄴㅈ),
      ]
    ),
    (
      "ㄱㅏㄴㅎ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(종성Symbol.ㄴㅎ),
      ]
    ),
    (
      "ㄱㅏㄹㄱ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(종성Symbol.ㄹㄱ),
      ]
    ),
    (
      "ㄱㅏㄹㅁ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(종성Symbol.ㄹㅁ),
      ]
    ),
    (
      "ㄱㅏㄹㅂ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(종성Symbol.ㄹㅂ),
      ]
    ),
    (
      "ㄱㅏㄹㅅ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(종성Symbol.ㄹㅅ),
      ]
    ),
    (
      "ㄱㅏㄹㅌ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(종성Symbol.ㄹㅌ),
      ]
    ),
    (
      "ㄱㅏㄹㅍ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(종성Symbol.ㄹㅍ),
      ]
    ),
    (
      "ㄱㅏㄹㅎ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(종성Symbol.ㄹㅎ),
      ]
    ),
    (
      "ㄱㅏㅂㅅ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(중성Symbol.ㅏ),
        Symbol(종성Symbol.ㅂㅅ),
      ]
    ),
  ]) func testParse겹받침(arg: (String, [Symbol])) {
    let (str, expected) = arg
    #expect(str_to_두벌식tokens(str).parse() == expected)
  }
  
  @Test(arguments: [
    (
      "",
      []
    ),
    (
      "ㄱ",
      [
        Symbol(초성Symbol.ㄱ),
      ]
    ),
    (
      "ㅏㅣ",
      [
        Symbol(중성Symbol.ㅏ),
        Symbol(중성Symbol.ㅣ),
      ]
    ),
    (
      "ㄱㄴㄷ",
      [
        Symbol(초성Symbol.ㄱ),
        Symbol(초성Symbol.ㄴ),
        Symbol(초성Symbol.ㄷ),
      ]
    ),
  ]) func testParseEdgeCases(arg: (String, [Symbol])) {
    let (str, expected) = arg
    #expect(str_to_두벌식tokens(str).parse() == expected)
  }
}
