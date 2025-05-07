typealias 천지인PreParser = TypeA자음PreParser<Heekey천지인모음, Heekey천지인Punctuations>

extension Sequence where Element == Heekey천지인Token {
  func parse() -> [Symbol] {
    천지인PostParser.parse(
      tokens: 천지인PreParser.parse(
        tokens: self.map {
          .init(from: $0)
        }
      )
    )
  }
}

fileprivate extension 천지인PreParser.Input {
  init(from: Heekey천지인Token) {
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
    case .모음(.ㆍ): self = .모음(.ㆍ)
    case .모음(.ㅡ): self = .모음(.ㅡ)
    case .모음(.ㅣ): self = .모음(.ㅣ)
    case .punctuations(.dot): self = .other(.dot)
    case .punctuations(.comma): self = .other(.comma)
    case .punctuations(.questionMark): self = .other(.questionMark)
    case .punctuations(.exclamationMark): self = .other(.exclamationMark)
    }
  }
}
