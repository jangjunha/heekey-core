enum Symbol {
  case 초성(초성Symbol)
  case 중성(중성Symbol)
  case 종성(종성Symbol)
}

extension Symbol: Equatable {}

extension Symbol {
  public init(_ value: 초성Symbol) {
    self = .초성(value)
  }

  public init(_ value: 중성Symbol) {
    self = .중성(value)
  }

  public init(_ value: 종성Symbol) {
    self = .종성(value)
  }
}

extension Symbol {
  var char: Character {
    switch self {
    case let .초성(v): return v.char
    case let .중성(v): return v.char
    case let .종성(v): return v.char
    }
  }
}
