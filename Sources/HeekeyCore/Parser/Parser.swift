import Foundation

extension Sequence where Element == Token {
  func parse() -> [Symbol] {
    PostParser.parse(tokens: PreParser.parse(tokens: self))
  }
}

enum PreParser {
  /// 자음을 초성 혹은 종성으로 분류

  public static func parse<S: Sequence>(tokens: S) -> [IntermediateToken]
  where S.Element == Token {
    var outputs = [IntermediateToken]()
    var it = tokens.makeIterator()

    var prev = it.next()
    while let curr = prev {
      let next = it.next()
      let res = parse_next(last: outputs.last, p1: curr, p2: next)
      outputs.append(res)
      prev = next
    }
    return outputs
  }

  static func parse_next(last: IntermediateToken?, p1: Token, p2: Token?) -> IntermediateToken {
    switch (last, p1, p2) {
    // 모음은 패스
    case let (_, .모음(p1), _): return .init(p1)
    // 종성이 될 수 없는 자음들
    case let (_, .자음(p1), _) where [.ㄷㄷ, .ㅂㅂ, .ㅈㅈ].contains(p1): return .init(초성(from: p1))

    case let (nil, .자음(p1), _): return .init(초성(from: p1))
    case let (.초성(_), .자음(p1), _): return .init(초성(from: p1))

    // 받침이 가능하지만 뒤에 모음이 나오면 초성
    case let (.모음, .자음(p1), .모음(_)):
      return .init(초성(from: p1))
    case let (.모음, .자음(p1), .자음(_)),
      let (.모음, .자음(p1), nil):
      return .init(종성(from: p1))

    // 겹받침 완성
    case (.종성(.ㄱ), .자음(.ㅅ), .자음(_)),
      (.종성(.ㄱ), .자음(.ㅅ), nil):
      return .init(종성(from: .ㅅ))
    case let (.종성(.ㄴ), .자음(p1), .자음(_)) where [.ㅈ, .ㅎ].contains(p1),
      let (.종성(.ㄴ), .자음(p1), nil) where [.ㅈ, .ㅎ].contains(p1):
      return .init(종성(from: p1))
    case let (.종성(.ㄹ), .자음(p1), .자음(_)) where [.ㄱ, .ㅁ, .ㅂ, .ㅅ, .ㅌ, .ㅍ, .ㅎ].contains(p1),
      let (.종성(.ㄹ), .자음(p1), nil) where [.ㄱ, .ㅁ, .ㅂ, .ㅅ, .ㅌ, .ㅍ, .ㅎ].contains(p1):
      return .init(종성(from: p1))
    case (.종성(.ㅂ), .자음(.ㅅ), .자음(_)),
      (.종성(.ㅂ), .자음(.ㅅ), nil):
      return .init(종성(from: .ㅅ))
    // 겹받침 완성 케이스 외 겹받침 불가
    case let (.종성(_), .자음(p1), .자음(_)),
      let (.종성(_), .자음(p1), nil):
      return .init(초성(from: p1))

    // 모음 등장으로 겹받침 안함
    case let (.종성(_), .자음(p1), .모음(_)):
      return .init(초성(from: p1))
    }
  }
}

enum PostParser {
  /// 조합 가능한 자소들을 조합하여 중성으로 변환 (모음, 받침)

  public static func parse<S: Sequence>(tokens: S) -> [Symbol]
  where S.Element == IntermediateToken {
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

extension 초성 {
  init(from token: 자음) {
    switch token {
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

extension 중성 {
  init(from token: 모음) {
    switch token {
    case .ㅏ: self = .ㅏ
    case .ㅑ: self = .ㅑ
    case .ㅓ: self = .ㅓ
    case .ㅕ: self = .ㅕ
    case .ㅗ: self = .ㅗ
    case .ㅛ: self = .ㅛ
    case .ㅜ: self = .ㅜ
    case .ㅠ: self = .ㅠ
    case .ㅡ: self = .ㅡ
    case .ㅣ: self = .ㅣ
    }
  }
}

extension 종성 {
  init(from token: 자음) {
    switch token {
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
      assertionFailure("No 종성 for \(token)")
      self = .ㄷ
    case .ㅂㅂ:
      assertionFailure("No 종성 for \(token)")
      self = .ㅂ
    case .ㅈㅈ:
      assertionFailure("No 종성 for \(token)")
      self = .ㅈ
    }
  }
}
