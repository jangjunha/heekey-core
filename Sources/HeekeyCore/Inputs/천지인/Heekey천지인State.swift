import Foundation

public struct Heekey천지인State: Equatable {
  public let tokens: [Heekey천지인Token]

  public init(tokens: [Heekey천지인Token]) {
    self.tokens = tokens
  }
}

extension Heekey천지인State: HeekeyInputState {
  public var string: String {
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
    switch action {
    case .기능(.backspace):
      return ("", Self(tokens: self.tokens.dropLast()))
    case .완성문자(let str):
      return (self.string + str, Self(tokens: []))

    case .조합문자(.ㅣ, _):
      return self.appending(.모음요소(.ㅣ))
    case .조합문자(.ㅡ, _):
      return self.appending(.모음요소(.ㅡ))
    case .조합문자(.천, _):
      // ㆍㆍ 상태에서 ㆍ를 누르면 ㆍ로 순환 (예: ㅑ → ㅏ, ㅠ → ㅜ)
      if self.tokens.suffix(2) == [.모음요소(.천), .모음요소(.천)] {
        return ("", Self(tokens: self.tokens.dropLast()))
      }
      return self.appending(.모음요소(.천))

    case .조합문자(let key, let 연속입력):
      guard let group = key.자음순환 else {
        assertionFailure("자음 키가 아님: \(key)")
        return ("", self)
      }
      if 연속입력,
        case .자음(let last) = self.tokens.last,
        let index = group.firstIndex(of: last)
      {
        let next = group[(index + 1) % group.count]
        return ("", Self(tokens: self.tokens.dropLast() + [.자음(next)]))
      }
      return self.appending(.자음(group[0]))
    }
  }
}

fileprivate extension Heekey천지인State {
  func appending(_ token: Heekey천지인Token) -> (String, Self) {
    return ("", Self(tokens: self.tokens + [token]))
  }
}

fileprivate extension Heekey천지인조합문자 {
  /// 멀티탭 순환 순서. 모음 키는 nil.
  var 자음순환: [Heekey천지인자음]? {
    switch self {
    case .ㄱㅋ: return [.ㄱ, .ㅋ, .ㄱㄱ]
    case .ㄴㄹ: return [.ㄴ, .ㄹ]
    case .ㄷㅌ: return [.ㄷ, .ㅌ, .ㄷㄷ]
    case .ㅂㅍ: return [.ㅂ, .ㅍ, .ㅂㅂ]
    case .ㅅㅎ: return [.ㅅ, .ㅎ, .ㅅㅅ]
    case .ㅈㅊ: return [.ㅈ, .ㅊ, .ㅈㅈ]
    case .ㅇㅁ: return [.ㅇ, .ㅁ]
    case .ㅣ, .천, .ㅡ: return nil
    }
  }
}
