import Foundation

public struct Heekey천지인State: Equatable {
  public let tokens: [Heekey천지인Token]
}

extension Heekey천지인State: HeekeyInputState {
  public var string: String {
    // TODO: CachedParser
    String(
      String(self.tokens.parse().map { $0.char }).precomposedStringWithCanonicalMapping.flatMap {
        $0.한글완성형
      }
    )
  }
  public var isEmpty: Bool {
    self.tokens.isEmpty
  }

  public func dispatch(action: Heekey천지인Action) -> (String, Self) {
    // TODO:
  }
}

fileprivate extension Heekey천지인Token {
  func rotate() -> Heekey천지인Token? {
    switch self {
    case .자음(.ㄱ): return .자음(.ㅋ)
    case .자음(.ㅋ): return .자음(.ㄱㄱ)
    case .자음(.ㄱㄱ): return .자음(.ㄱ)

    case .자음(.ㄴ): return .자음(.ㄹ)
    case .자음(.ㄹ): return .자음(.ㄴ)

    case .자음(.ㄷ): return .자음(.ㅌ)
    case .자음(.ㅌ): return .자음(.ㄷㄷ)
    case .자음(.ㄷㄷ): return .자음(.ㄷ)

    case .자음(.ㅂ): return .자음(.ㅍ)
    case .자음(.ㅍ): return .자음(.ㅂㅂ)
    case .자음(.ㅂㅂ): return .자음(.ㅂ)

    case .자음(.ㅅ): return .자음(.ㅎ)
    case .자음(.ㅎ): return .자음(.ㅅㅅ)
    case .자음(.ㅅㅅ): return .자음(.ㅅ)

    case .자음(.ㅈ): return .자음(.ㅊ)
    case .자음(.ㅊ): return .자음(.ㅈㅈ)
    case .자음(.ㅈㅈ): return .자음(.ㅈ)

    case .자음(.ㅇ): return .자음(.ㅁ)
    case .자음(.ㅁ): return .자음(.ㅇ)

    case .모음(_): return nil

    case .punctuations(.dot): return .punctuations(.comma)
    case .punctuations(.comma): return .punctuations(.questionMark)
    case .punctuations(.questionMark): return .punctuations(.exclamationMark)
    case .punctuations(.exclamationMark): return .punctuations(.dot)
    }
  }
}
