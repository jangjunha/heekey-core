import Testing

@testable import HeekeyCore

@Suite struct Heekey천지인ParserTests {
  @Test(arguments: [
    // Compose 'ㅕ'
    (
      "ㆍㆍㅣ",
      [
        Symbol(중성Symbol.ㅕ),
      ]
    ),
    (
      "ㆍㅣㆍ",
      [
        Symbol(중성Symbol.ㅕ),
      ]
    ),

    (
      "ㅡㆍㆍㅣ",
      [
        Symbol(중성Symbol.ㅝ),
      ]
    ),

    // TODO:
  ]) func testParse모음(arg: (String, [Symbol])) {
    let (str, expected) = arg
    #expect(str_to_천지인tokens(str).parse() == expected)
  }

  @Test(arguments: [
    // TODO:
  ]) func testParse받침(arg: (String, [Symbol])) {
    let (str, expected) = arg
    #expect(str_to_천지인tokens(str).parse() == expected)
  }
}
