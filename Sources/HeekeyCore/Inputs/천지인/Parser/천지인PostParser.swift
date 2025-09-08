enum 천지인PostParser {
  typealias Input = 천지인PreParser.Output
  typealias Output = Symbol

  public static func parse<S: Sequence>(tokens: S) -> [Output]
  where S.Element == Input {
    var it = tokens.makeIterator()
    switch (it.next(), it.next(), it.next()) {
    case (nil, _, _): return []

    // 모음 조합
    // TODO:

    // 받침 조합
    // TODO:

    // else
    // TODO:
    }
  }
}
