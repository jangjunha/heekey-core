enum 두벌식PostParser {
  typealias Input = 두벌식PreParser.Output
  typealias Output = Symbol

  public static func parse<S: Sequence>(tokens: S) -> [Symbol]
  where S.Element == Input {
    var it = tokens.makeIterator()
    switch (it.next(), it.next()) {
    case (nil, _): return []

    // 모음 조합
    case (.모음(.ㅡ), .모음(.ㅣ)):
      return [.중성(.ㅢ)] + parse(tokens: tokens.dropFirst(2))
    case (.모음(.ㅜ), .모음(.ㅣ)):
      return [.중성(.ㅟ)] + parse(tokens: tokens.dropFirst(2))
    case (.모음(.ㅜ), .모음(.ㅔ)):
      return [.중성(.ㅞ)] + parse(tokens: tokens.dropFirst(2))
    case (.모음(.ㅜ), .모음(.ㅓ)):
      return [.중성(.ㅝ)] + parse(tokens: tokens.dropFirst(2))
    case (.모음(.ㅗ), .모음(.ㅣ)):
      return [.중성(.ㅚ)] + parse(tokens: tokens.dropFirst(2))
    case (.모음(.ㅗ), .모음(.ㅐ)):
      return [.중성(.ㅙ)] + parse(tokens: tokens.dropFirst(2))
    case (.모음(.ㅗ), .모음(.ㅏ)):
      return [.중성(.ㅘ)] + parse(tokens: tokens.dropFirst(2))
    case (.모음(let v), _): return [.중성(v)] + parse(tokens: tokens.dropFirst())

    // 받침 조합
    case (.종성(.ㄱ), .종성(.ㅅ)): return [.종성(.ㄱㅅ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄴ), .종성(.ㅈ)): return [.종성(.ㄴㅈ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄴ), .종성(.ㅎ)): return [.종성(.ㄴㅎ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄹ), .종성(.ㄱ)): return [.종성(.ㄹㄱ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄹ), .종성(.ㅁ)): return [.종성(.ㄹㅁ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄹ), .종성(.ㅂ)): return [.종성(.ㄹㅂ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄹ), .종성(.ㅅ)): return [.종성(.ㄹㅅ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄹ), .종성(.ㅌ)): return [.종성(.ㄹㅌ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄹ), .종성(.ㅍ)): return [.종성(.ㄹㅍ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㄹ), .종성(.ㅎ)): return [.종성(.ㄹㅎ)] + parse(tokens: tokens.dropFirst(2))
    case (.종성(.ㅂ), .종성(.ㅅ)): return [.종성(.ㅂㅅ)] + parse(tokens: tokens.dropFirst(2))

    case (.초성(let v), _): return [.초성(.init(v))] + parse(tokens: tokens.dropFirst())
    case (.종성(let v), _): return [.종성(.init(v))] + parse(tokens: tokens.dropFirst())
    }
  }
}

fileprivate extension 초성Symbol {
  init(_ from: TypeA자음Token) {
    switch from {
    case .ㄱ: self = .ㄱ
    case .ㄱㄱ: self = .ㄱㄱ
    case .ㄴ: self = .ㄴ
    case .ㄷ: self = .ㄷ
    case .ㄷㄷ: self = .ㄷㄷ
    case .ㄹ: self = .ㄹ
    case .ㅁ: self = .ㅁ
    case .ㅂ: self = .ㅂ
    case .ㅂㅂ: self = .ㅂㅂ
    case .ㅅ: self = .ㅅ
    case .ㅅㅅ: self = .ㅅㅅ
    case .ㅇ: self = .ㅇ
    case .ㅈ: self = .ㅈ
    case .ㅈㅈ: self = .ㅈㅈ
    case .ㅊ: self = .ㅊ
    case .ㅋ: self = .ㅋ
    case .ㅌ: self = .ㅌ
    case .ㅍ: self = .ㅍ
    case .ㅎ: self = .ㅎ
    }
  }
}

fileprivate extension 종성Symbol {
  init(_ from: TypeA자음Token) {
    switch from {
    case .ㄱ: self = .ㄱ
    case .ㄱㄱ: self = .ㄱㄱ
    case .ㄴ: self = .ㄴ
    case .ㄷ: self = .ㄷ
    case .ㄹ: self = .ㄹ
    case .ㅁ: self = .ㅁ
    case .ㅂ: self = .ㅂ
    case .ㅅ: self = .ㅅ
    case .ㅅㅅ: self = .ㅅㅅ
    case .ㅇ: self = .ㅇ
    case .ㅈ: self = .ㅈ
    case .ㅊ: self = .ㅊ
    case .ㅋ: self = .ㅋ
    case .ㅌ: self = .ㅌ
    case .ㅍ: self = .ㅍ
    case .ㅎ: self = .ㅎ
    case .ㄷㄷ:
      assertionFailure("No 종성 for \(from)")
      self = .ㄷ
    case .ㅂㅂ:
      assertionFailure("No 종성 for \(from)")
      self = .ㅂ
    case .ㅈㅈ:
      assertionFailure("No 종성 for \(from)")
      self = .ㅈ
    }
  }
}
