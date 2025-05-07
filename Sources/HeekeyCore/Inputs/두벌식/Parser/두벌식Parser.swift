typealias 두벌식PreParser = TypeA자음PreParser<중성Symbol>

extension Sequence where Element == Heekey두벌식Token {
  func parse() -> [Symbol] {
    두벌식PostParser.parse(
      tokens: 두벌식PreParser.parse(
        tokens: self.map {
          .init(from: $0)
        }
      )
    )
  }
}

fileprivate extension 두벌식PreParser.Input {
  init(from: Heekey두벌식Token) {
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
    case .모음(.ㅏ): self = .모음(.ㅏ)
    case .모음(.ㅐ): self = .모음(.ㅐ)
    case .모음(.ㅑ): self = .모음(.ㅑ)
    case .모음(.ㅒ): self = .모음(.ㅒ)
    case .모음(.ㅓ): self = .모음(.ㅓ)
    case .모음(.ㅔ): self = .모음(.ㅔ)
    case .모음(.ㅕ): self = .모음(.ㅕ)
    case .모음(.ㅖ): self = .모음(.ㅖ)
    case .모음(.ㅗ): self = .모음(.ㅗ)
    case .모음(.ㅛ): self = .모음(.ㅛ)
    case .모음(.ㅜ): self = .모음(.ㅜ)
    case .모음(.ㅠ): self = .모음(.ㅠ)
    case .모음(.ㅡ): self = .모음(.ㅡ)
    case .모음(.ㅣ): self = .모음(.ㅣ)
    }
  }
}
