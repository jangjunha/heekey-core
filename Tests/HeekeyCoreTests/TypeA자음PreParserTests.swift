import Testing

@testable import HeekeyCore

@Suite struct TypeA자음PreParserTests {
  typealias Parser = TypeA자음PreParser<String>
  typealias Input = TypeA자음PreParserInputToken<String>
  typealias Output = TypeA자음PreParserOutputToken<String>

  @Test func testEmptyInput() {
    let result = Parser.parse(tokens: [])
    #expect(result.isEmpty)
  }
  
  @Test func testSingleVowel() {
    let input = [Input.모음("")]
    let result = Parser.parse(tokens: input)
    #expect(result == [Output.모음("")])
  }
  
  @Test func testSingleConsonant() {
    let input = [Input.자음(.ㄱ)]
    let result = Parser.parse(tokens: input)
    #expect(result == [Output.초성(.ㄱ)])
  }
  
  @Test func testDoubleConsonant() {
    let input = [Input.자음(.ㄷㄷ)] // 쌍자음
    let result = Parser.parse(tokens: input)
    #expect(result == [Output.초성(.ㄷㄷ)])
  }
  
  @Test func testConsonantFollowedByConsonant() {
    let input = [Input.자음(.ㄱ), Input.자음(.ㄴ)]
    let result = Parser.parse(tokens: input)
    #expect(result == [Output.초성(.ㄱ), Output.초성(.ㄴ)])
  }
  
  @Test func testVowelConsonantVowel() {
    let input = [Input.모음(""), Input.자음(.ㄱ), Input.모음("")]
    let result = Parser.parse(tokens: input)
    #expect(result == [Output.모음(""), Output.초성(.ㄱ), Output.모음("")])
  }
  
  @Test func testVowelConsonant() {
    let input = [Input.모음(""), Input.자음(.ㄱ)]
    let result = Parser.parse(tokens: input)
    #expect(result == [Output.모음(""), Output.종성(.ㄱ)])
  }
  
  @Test func testVowelConsonantConsonant() {
    let input = [Input.모음(""), Input.자음(.ㄱ), Input.자음(.ㄴ)]
    let result = Parser.parse(tokens: input)
    #expect(result == [Output.모음(""), Output.종성(.ㄱ), Output.초성(.ㄴ)])
  }
  
  @Test func testValidDoubleFinalConsonants() {
    // 모음 + ㄱ + ㅅ (valid double final)
    let input1 = [Input.모음(""), Input.자음(.ㄱ), Input.자음(.ㅅ)]
    #expect(Parser.parse(tokens: input1) == [Output.모음(""), Output.종성(.ㄱ), Output.종성(.ㅅ)])
    
    // 모음 + ㄴ + ㅈ (valid double final)
    let input2 = [Input.모음(""), Input.자음(.ㄴ), Input.자음(.ㅈ)]
    #expect(Parser.parse(tokens: input2) == [Output.모음(""), Output.종성(.ㄴ), Output.종성(.ㅈ)])
    
    // 모음 + ㄹ + ㅂ (valid double final)
    let input3 = [Input.모음(""), Input.자음(.ㄹ), Input.자음(.ㅂ)]
    #expect(Parser.parse(tokens: input3) == [Output.모음(""), Output.종성(.ㄹ), Output.종성(.ㅂ)])
    
    // 모음 + ㅂ + ㅅ (valid double final)
    let input4 = [Input.모음(""), Input.자음(.ㅂ), Input.자음(.ㅅ)]
    #expect(Parser.parse(tokens: input4) == [Output.모음(""), Output.종성(.ㅂ), Output.종성(.ㅅ)])
  }
  
  @Test func testInvalidDoubleFinalConsonants() {
    let input = [Input.모음(""), Input.자음(.ㄴ), Input.자음(.ㄱ)]
    let result = Parser.parse(tokens: input)
    #expect(result == [Output.모음(""), Output.종성(.ㄴ), Output.초성(.ㄱ)])
  }
  
  @Test func testDoubleFinalConsonantFollowedByVowel() {
    let input = [Input.모음(""), Input.자음(.ㄱ), Input.자음(.ㅅ), Input.모음("")]
    let result = Parser.parse(tokens: input)
    #expect(result == [Output.모음(""), Output.종성(.ㄱ), Output.초성(.ㅅ), Output.모음("")])  
  }
  
  @Test func testComplexSequence() {
    let input = [
      Input.자음(.ㄱ),   // 초성
      Input.모음(""),    // 모음
      Input.자음(.ㄴ),   // 종성
      Input.자음(.ㄷ),   // 초성
      Input.모음(""),    // 모음
      Input.자음(.ㄹ),   // 종성
      Input.자음(.ㅂ)    // 종성 (part of double)
    ]
    let result = Parser.parse(tokens: input)
    #expect(result == [
      Output.초성(.ㄱ),
      Output.모음(""),
      Output.종성(.ㄴ),
      Output.초성(.ㄷ),
      Output.모음(""),
      Output.종성(.ㄹ),
      Output.종성(.ㅂ)
    ])
  }
  
  @Test(arguments: [
    // Basic consonant classification
    (
      // Single consonant
      [Input.자음(.ㄱ)],
      [Output.초성(.ㄱ)]
    ),
    (
      // Double consonant (always 초성)
      [Input.자음(.ㄷㄷ)],
      [Output.초성(.ㄷㄷ)]
    ),
    
    // Vowel followed by consonant
    (
      // 모음 + ㄱ
      [Input.모음(""), Input.자음(.ㄱ)],
      [
        Output.모음(""),
        Output.종성(.ㄱ)
      ]
    ),
    
    // Consonant combinations
    (
      // 모음 + ㄱ + ㅅ (valid double final)
      [Input.모음(""), Input.자음(.ㄱ), Input.자음(.ㅅ)],
      [
        Output.모음(""),
        Output.종성(.ㄱ),
        Output.종성(.ㅅ)
      ]
    ),
    (
      // 모음 + ㄱ + ㅅ + 모음 (ㅅ should be 초성)
      [Input.모음(""), Input.자음(.ㄱ), Input.자음(.ㅅ), Input.모음("")],
      [
        Output.모음(""),
        Output.종성(.ㄱ),
        Output.초성(.ㅅ),
        Output.모음("")
      ]
    ),
    (
      // 모음 + ㄴ + ㄱ (ㄱ should be 초성 - invalid double)
      [Input.모음(""), Input.자음(.ㄴ), Input.자음(.ㄱ)],
      [
        Output.모음(""),
        Output.종성(.ㄴ),
        Output.초성(.ㄱ)
      ]
    ),
    
    // Complex sequences
    (
      // ㄱ + 모음 + ㄴ + ㄷ + 모음
      [Input.자음(.ㄱ), Input.모음(""), Input.자음(.ㄴ), Input.자음(.ㄷ), Input.모음("")],
      [
        Output.초성(.ㄱ),
        Output.모음(""),
        Output.종성(.ㄴ),
        Output.초성(.ㄷ),
        Output.모음("")
      ]
    ),
  ]) func testVariousCases(arg: ([Input], [Output])) {
    let (input, expected) = arg
    let result = Parser.parse(tokens: input)
    #expect(result == expected)
  }
}
