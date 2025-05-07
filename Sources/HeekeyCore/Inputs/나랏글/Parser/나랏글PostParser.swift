enum NaratgeulPostParser {
  /// 조합 가능한 자소들을 조합하여 중성으로 변환 (모음, 받침)

  public static func parse<S: Sequence>(tokens: S) -> [Symbol]
  where S.Element == 나랏글IntermediateToken {
    var it = tokens.makeIterator()
    switch (it.next(), it.next(), it.next()) {
    case (nil, _, _): return []

    // 모음 조합
    case (.모음(.ㅣ), _, _):
      return [.중성(.ㅣ)] + parse(tokens: tokens.dropFirst(1))
    case (.모음(.ㅡ), .모음(.ㅣ), _):
      return [.중성(.ㅢ)] + parse(tokens: tokens.dropFirst(2))
    case (.모음(.ㅡ), _, _):
      return [.중성(.ㅡ)] + parse(tokens: tokens.dropFirst(1))
    case (.모음(.ㅠ), _, _):
      return [.중성(.ㅠ)] + parse(tokens: tokens.dropFirst(1))
    case (.모음(.ㅜ), .모음(.ㅣ), _):
      return [.중성(.ㅟ)] + parse(tokens: tokens.dropFirst(2))
    case (.모음(.ㅜ), .모음(.ㅓ), .모음(.ㅣ)):
      return [.중성(.ㅞ)] + parse(tokens: tokens.dropFirst(3))
    case (.모음(.ㅜ), .모음(.ㅓ), _):
      return [.중성(.ㅝ)] + parse(tokens: tokens.dropFirst(2))
    case (.모음(.ㅜ), _, _):
      return [.중성(.ㅜ)] + parse(tokens: tokens.dropFirst(1))
    case (.모음(.ㅛ), _, _):
      return [.중성(.ㅛ)] + parse(tokens: tokens.dropFirst(1))
    case (.모음(.ㅗ), .모음(.ㅣ), _):
      return [.중성(.ㅚ)] + parse(tokens: tokens.dropFirst(2))
    case (.모음(.ㅗ), .모음(.ㅏ), .모음(.ㅣ)):
      return [.중성(.ㅙ)] + parse(tokens: tokens.dropFirst(3))
    case (.모음(.ㅗ), .모음(.ㅏ), _):
      return [.중성(.ㅘ)] + parse(tokens: tokens.dropFirst(2))
    case (.모음(.ㅗ), _, _):
      return [.중성(.ㅗ)] + parse(tokens: tokens.dropFirst(1))
    case (.모음(.ㅕ), .모음(.ㅣ), _):
      return [.중성(.ㅖ)] + parse(tokens: tokens.dropFirst(2))
    case (.모음(.ㅕ), _, _):
      return [.중성(.ㅕ)] + parse(tokens: tokens.dropFirst(1))
    case (.모음(.ㅓ), .모음(.ㅣ), _):
      return [.중성(.ㅔ)] + parse(tokens: tokens.dropFirst(2))
    case (.모음(.ㅓ), _, _):
      return [.중성(.ㅓ)] + parse(tokens: tokens.dropFirst(1))
    case (.모음(.ㅑ), .모음(.ㅣ), _):
      return [.중성(.ㅒ)] + parse(tokens: tokens.dropFirst(2))
    case (.모음(.ㅑ), _, _):
      return [.중성(.ㅑ)] + parse(tokens: tokens.dropFirst(1))
    case (.모음(.ㅏ), .모음(.ㅣ), _):
      return [.중성(.ㅐ)] + parse(tokens: tokens.dropFirst(2))
    case (.모음(.ㅏ), _, _):
      return [.중성(.ㅏ)] + parse(tokens: tokens.dropFirst(1))

    // 받침 조합
    case (.종성(.ㄱ), .종성(.ㅅ), _): return [.종성(.ㄱㅅ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄴ), .종성(.ㅈ), _): return [.종성(.ㄴㅈ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄴ), .종성(.ㅎ), _): return [.종성(.ㄴㅎ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄹ), .종성(.ㄱ), _): return [.종성(.ㄹㄱ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄹ), .종성(.ㅁ), _): return [.종성(.ㄹㅁ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄹ), .종성(.ㅂ), _): return [.종성(.ㄹㅂ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄹ), .종성(.ㅅ), _): return [.종성(.ㄹㅅ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄹ), .종성(.ㅌ), _): return [.종성(.ㄹㅌ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄹ), .종성(.ㅍ), _): return [.종성(.ㄹㅍ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄹ), .종성(.ㅎ), _): return [.종성(.ㄹㅎ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㅂ), .종성(.ㅅ), _): return [.종성(.ㅂㅅ)] + parse(tokens: tokens.dropFirst(2))

    case (.초성(let v), _, _): return [.초성(v)] + parse(tokens: tokens.dropFirst())
    case (.종성(let v), _, _): return [.종성(v)] + parse(tokens: tokens.dropFirst())
    }
  }
}
