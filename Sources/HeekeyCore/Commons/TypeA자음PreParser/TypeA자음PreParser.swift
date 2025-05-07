enum TypeA자음PreParser<T: Equatable> {
  /// 자음을 초성 혹은 종성으로 분류

  typealias Input = TypeA자음PreParserInputToken<T>
  typealias Output = TypeA자음PreParserOutputToken<T>

  public static func parse<S: Sequence>(tokens: S) -> [Output] where S.Element == Input {
    var outputs = [Output]()
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

  static func parse_next(last: Output?, p1: Input, p2: Input?) -> Output {
    switch (last, p1, p2) {
    // 모음은 패스
    case let (_, .모음(p1), _): return .모음(p1)
    // 종성이 될 수 없는 자음들
    case let (_, .자음(p1), _) where [.ㄷㄷ, .ㅂㅂ, .ㅈㅈ].contains(p1): return .초성(p1)

    case let (nil, .자음(p1), _): return .초성(p1)
    case let (.초성(_), .자음(p1), _): return .초성(p1)

    // 받침이 가능하지만 뒤에 모음이 나오면 초성
    case let (.모음, .자음(p1), .모음(_)):
      return .초성(p1)
    case let (.모음, .자음(p1), .자음(_)),
      let (.모음, .자음(p1), nil):
      return .종성(p1)

    // 겹받침 완성
    case (.종성(.ㄱ), .자음(.ㅅ), .자음(_)),
      (.종성(.ㄱ), .자음(.ㅅ), nil):
      return .종성(.ㅅ)
    case let (.종성(.ㄴ), .자음(p1), .자음(_)) where [.ㅈ, .ㅎ].contains(p1),
      let (.종성(.ㄴ), .자음(p1), nil) where [.ㅈ, .ㅎ].contains(p1):
      return .종성(p1)
    case let (.종성(.ㄹ), .자음(p1), .자음(_)) where [.ㄱ, .ㅁ, .ㅂ, .ㅅ, .ㅌ, .ㅍ, .ㅎ].contains(p1),
      let (.종성(.ㄹ), .자음(p1), nil) where [.ㄱ, .ㅁ, .ㅂ, .ㅅ, .ㅌ, .ㅍ, .ㅎ].contains(p1):
      return .종성(p1)
    case (.종성(.ㅂ), .자음(.ㅅ), .자음(_)),
      (.종성(.ㅂ), .자음(.ㅅ), nil):
      return .종성(.ㅅ)
    // 겹받침 완성 케이스 외 겹받침 불가
    case let (.종성(_), .자음(p1), .자음(_)),
      let (.종성(_), .자음(p1), nil):
      return .초성(p1)

    // 모음 등장으로 겹받침 안함
    case let (.종성(_), .자음(p1), .모음(_)):
      return .초성(p1)
    }
  }
}
