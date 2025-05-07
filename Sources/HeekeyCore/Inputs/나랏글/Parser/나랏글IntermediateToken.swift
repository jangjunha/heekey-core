typealias 나랏글모음 = Heekey나랏글모음

enum 나랏글IntermediateToken {
  case 초성(초성Symbol)
  case 종성(종성Symbol)
  case 모음(나랏글모음)
}

extension 나랏글IntermediateToken {
  init(_ val: 초성Symbol) {
    self = .초성(val)
  }

  init(_ val: 종성Symbol) {
    self = .종성(val)
  }

  init(_ val: 나랏글모음) {
    self = .모음(val)
  }
}
