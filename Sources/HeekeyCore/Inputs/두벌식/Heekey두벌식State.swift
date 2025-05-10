import Foundation

public struct Heekey두벌식State {
  public let tokens: [Heekey두벌식Token]

  public init(tokens: [Heekey두벌식Token]) {
    self.tokens = tokens
  }
}

extension Heekey두벌식State: HeekeyInputState {
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

  public func dispatch(action: Heekey두벌식Action) -> (String, Self) {
    switch (self.tokens.last, action) {
    case (_, .기능(.backspace)):
      return ("", Self(tokens: self.tokens.dropLast()))
    case (_, .기능(.emit)):
      return (self.string, Self(tokens: []))
    case (_, .완성문자(let str)):
      return (self.string + str, Self(tokens: []))
    case (_, .조합문자(let key)):
      return ("", Self(tokens: self.tokens + [key.token]))
    }
  }
}
