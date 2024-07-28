import Foundation

typealias State = [Token]

extension State {
  public var string: String {
    // TODO: CachedParser
    String(
      String(self.parse().map { $0.char }).precomposedStringWithCanonicalMapping.flatMap {
        $0.완성형
      }
    )
  }

  public func dispatch(action: Action) -> (String, Self) {
    // self: current state
    // key: input
    // [0]: emitted string
    // [1]: next state

    switch (self.last, action) {
    // Common
    case (_, .기능(.backspace)):
      return ("", self.dropLast())
    case (_, .완성문자(let str)):
      return (self.string + str, [])

    // Beginning
    case (nil, .조합문자(let key)): return ("", [key.firstToken])
    case (nil, .기능): return ("", self)

    case (.자음, .조합문자(let key)):
      return self.appending(key.firstToken)
    case (.자음(let last), .기능(.쌍자음)):
      guard let next = last.쌍자음화() else {
        return self.noop()
      }
      return self.replacingLast(to: .init(next))
    case (.자음(let last), .기능(.획추가)):
      guard let next = last.rotate() else {
        return self.noop()
      }
      return self.replacingLast(to: .init(next))

    case (.모음(let last), .조합문자(let key)):
      switch (last, key) {
      // 모음 rotation
      case (.ㅏ, .ㅏㅓ): return self.replacingLast(to: .init(모음.ㅓ))
      case (.ㅓ, .ㅏㅓ): return self.replacingLast(to: .init(모음.ㅏ))
      case (.ㅗ, .ㅗㅜ): return self.replacingLast(to: .init(모음.ㅜ))
      case (.ㅜ, .ㅗㅜ): return self.replacingLast(to: .init(모음.ㅗ))
      // ㅝ
      case (.ㅜ, .ㅏㅓ): return self.appending(.init(모음.ㅓ))
      default: return self.appending(key.firstToken)
      }
    case (.모음, .기능(.쌍자음)):
      return self.noop()
    case (.모음(let last), .기능(.획추가)):
      switch last {
      case .ㅏ: return self.replacingLast(to: .모음(.ㅑ))
      case .ㅓ: return self.replacingLast(to: .모음(.ㅕ))
      case .ㅗ: return self.replacingLast(to: .모음(.ㅛ))
      case .ㅜ: return self.replacingLast(to: .모음(.ㅠ))
      case .ㅑ, .ㅕ, .ㅛ, .ㅠ, .ㅡ, .ㅣ: return self.noop()
      }
    }
  }

  private func noop() -> (String, Self) {
    return ("", self)
  }

  private func appending(_ token: Token) -> (String, Self) {
    return ("", self + [token])
  }

  private func replacingLast(to token: Token) -> (String, Self) {
    return ("", self.dropLast() + [token])
  }
}

extension Character {
  public var 완성형: [Character] {
    self.unicodeScalars.map {
      switch $0 {
      case "\u{1100}": return "ㄱ"
      case "\u{1101}": return "ㄲ"
      case "\u{1102}": return "ㄴ"
      case "\u{1103}": return "ㄷ"
      case "\u{1104}": return "ㄸ"
      case "\u{1105}": return "ㄹ"
      case "\u{1106}": return "ㅁ"
      case "\u{1107}": return "ㅂ"
      case "\u{1108}": return "ㅃ"
      case "\u{1109}": return "ㅅ"
      case "\u{110A}": return "ㅆ"
      case "\u{110B}": return "ㅇ"
      case "\u{110C}": return "ㅈ"
      case "\u{110D}": return "ㅉ"
      case "\u{110E}": return "ㅊ"
      case "\u{110F}": return "ㅋ"
      case "\u{1110}": return "ㅌ"
      case "\u{1111}": return "ㅍ"
      case "\u{1112}": return "ㅎ"
      default: return Character($0)
      }
    }
  }
}

extension 조합문자 {
  var firstToken: Token {
    switch self {
    case .ㄱ: return .자음(.ㄱ)
    case .ㄴ: return .자음(.ㄴ)
    case .ㄹ: return .자음(.ㄹ)
    case .ㅁ: return .자음(.ㅁ)
    case .ㅅ: return .자음(.ㅅ)
    case .ㅇ: return .자음(.ㅇ)
    case .ㅏㅓ: return .모음(.ㅏ)
    case .ㅗㅜ: return .모음(.ㅗ)
    case .ㅡ: return .모음(.ㅡ)
    case .ㅣ: return .모음(.ㅣ)
    }
  }
}

extension 자음 {
  func 쌍자음화() -> 자음? {
    switch self {
    case .ㄱ: return .ㄱㄱ
    case .ㄱㄱ: return .ㄱ
    case .ㄷ: return .ㄷㄷ
    case .ㄷㄷ: return .ㄷ
    case .ㅂ: return .ㅂㅂ
    case .ㅂㅂ: return .ㅂ
    case .ㅅ: return .ㅅㅅ
    case .ㅅㅅ: return .ㅅ
    case .ㅈ: return .ㅈㅈ
    case .ㅈㅈ: return .ㅈ
    case .ㄴ, .ㄹ, .ㅁ, .ㅇ, .ㅊ, .ㅋ, .ㅌ, .ㅍ, .ㅎ: return nil
    }
  }

  func rotate() -> 자음? {
    switch self {
    case .ㄱ: return .ㅋ
    case .ㅋ: return .ㄱ

    case .ㄴ: return .ㄷ
    case .ㄷ: return .ㅌ
    case .ㅌ: return .ㄴ

    case .ㅁ: return .ㅂ
    case .ㅂ: return .ㅍ
    case .ㅍ: return .ㅁ

    case .ㅅ: return .ㅈ
    case .ㅈ: return .ㅊ
    case .ㅊ: return .ㅅ

    case .ㅇ: return .ㅎ
    case .ㅎ: return .ㅇ

    case .ㄹ: return nil
    case .ㄱㄱ, .ㄷㄷ, .ㅂㅂ, .ㅅㅅ, .ㅈㅈ: return nil
    }
  }
}
