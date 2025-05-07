extension Sequence where Element == Heekey나랏글Token {
  func parse() -> [Symbol] {
    NaratgeulPostParser.parse(
      tokens: TypeA자음PreParser<나랏글모음>.parse(
        tokens: self.map {
          .init(from: $0)
        }
      ).map {
        .init(from: $0)
      }
    )
  }
}

fileprivate extension TypeA자음PreParserInputToken<나랏글모음> {
  init(from: Heekey나랏글Token) {
    switch from {
    case .자음(.ㄱ): self = .자음(.ㄱ)
    case .자음(.ㄱㄱ): self = .자음(.ㄱㄱ)
    case .자음(.ㄴ): self = .자음(.ㄴ)
    case .자음(.ㄷ): self = .자음(.ㄷ)
    case .자음(.ㄷㄷ): self = .자음(.ㄷㄷ)
    case .자음(.ㄹ): self = .자음(.ㄹ)
    case .자음(.ㅁ): self = .자음(.ㅁ)
    case .자음(.ㅂ): self = .자음(.ㅂ)
    case .자음(.ㅂㅂ): self = .자음(.ㅂㅂ)
    case .자음(.ㅅ): self = .자음(.ㅅ)
    case .자음(.ㅅㅅ): self = .자음(.ㅅㅅ)
    case .자음(.ㅇ): self = .자음(.ㅇ)
    case .자음(.ㅈ): self = .자음(.ㅈ)
    case .자음(.ㅈㅈ): self = .자음(.ㅈㅈ)
    case .자음(.ㅊ): self = .자음(.ㅊ)
    case .자음(.ㅋ): self = .자음(.ㅋ)
    case .자음(.ㅌ): self = .자음(.ㅌ)
    case .자음(.ㅍ): self = .자음(.ㅍ)
    case .자음(.ㅎ): self = .자음(.ㅎ)
    case .모음(let v): self = .모음(v)
    }
  }
}

fileprivate extension 나랏글IntermediateToken {
  init(from: TypeA자음PreParserOutputToken<나랏글모음>) {
    switch from {
    case .초성(.ㄱ): self = .초성(.ㄱ)
    case .초성(.ㄱㄱ): self = .초성(.ㄱㄱ)
    case .초성(.ㄴ): self = .초성(.ㄴ)
    case .초성(.ㄷ): self = .초성(.ㄷ)
    case .초성(.ㄷㄷ): self = .초성(.ㄷㄷ)
    case .초성(.ㄹ): self = .초성(.ㄹ)
    case .초성(.ㅁ): self = .초성(.ㅁ)
    case .초성(.ㅂ): self = .초성(.ㅂ)
    case .초성(.ㅂㅂ): self = .초성(.ㅂㅂ)
    case .초성(.ㅅ): self = .초성(.ㅅ)
    case .초성(.ㅅㅅ): self = .초성(.ㅅㅅ)
    case .초성(.ㅇ): self = .초성(.ㅇ)
    case .초성(.ㅈ): self = .초성(.ㅈ)
    case .초성(.ㅈㅈ): self = .초성(.ㅈㅈ)
    case .초성(.ㅊ): self = .초성(.ㅊ)
    case .초성(.ㅋ): self = .초성(.ㅋ)
    case .초성(.ㅌ): self = .초성(.ㅌ)
    case .초성(.ㅍ): self = .초성(.ㅍ)
    case .초성(.ㅎ): self = .초성(.ㅎ)
    case .종성(.ㄱ): self = .종성(.ㄱ)
    case .종성(.ㄱㄱ): self = .종성(.ㄱㄱ)
    case .종성(.ㄴ): self = .종성(.ㄴ)
    case .종성(.ㄷ): self = .종성(.ㄷ)
    case .종성(.ㄹ): self = .종성(.ㄹ)
    case .종성(.ㅁ): self = .종성(.ㅁ)
    case .종성(.ㅂ): self = .종성(.ㅂ)
    case .종성(.ㅅ): self = .종성(.ㅅ)
    case .종성(.ㅅㅅ): self = .종성(.ㅅㅅ)
    case .종성(.ㅇ): self = .종성(.ㅇ)
    case .종성(.ㅈ): self = .종성(.ㅈ)
    case .종성(.ㅊ): self = .종성(.ㅊ)
    case .종성(.ㅋ): self = .종성(.ㅋ)
    case .종성(.ㅌ): self = .종성(.ㅌ)
    case .종성(.ㅍ): self = .종성(.ㅍ)
    case .종성(.ㅎ): self = .종성(.ㅎ)
    case .종성(.ㄷㄷ):
      assertionFailure("No 종성 for \(from)")
      self = .종성(.ㄷ)
    case .종성(.ㅂㅂ):
      assertionFailure("No 종성 for \(from)")
      self = .종성(.ㅂ)
    case .종성(.ㅈㅈ):
      assertionFailure("No 종성 for \(from)")
      self = .종성(.ㅈ)
    case .모음(let v): self = .모음(v)
    }
  }
}
