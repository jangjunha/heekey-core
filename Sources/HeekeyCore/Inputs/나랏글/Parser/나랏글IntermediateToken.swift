typealias 나랏글모음 = Heekey나랏글모음

enum 나랏글IntermediateToken {
  case 초성(나랏글초성)
  case 종성(나랏글종성)
  case 모음(나랏글모음)
}

extension 나랏글IntermediateToken {
  init(_ val: 나랏글초성) {
    self = .초성(val)
  }

  init(_ val: 나랏글종성) {
    self = .종성(val)
  }

  init(_ val: 나랏글모음) {
    self = .모음(val)
  }
}
