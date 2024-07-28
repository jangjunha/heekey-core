public enum IntermediateToken {
  case 초성(초성)
  case 종성(종성)
  case 모음(모음)
}

extension IntermediateToken {
  init(_ val: 초성) {
    self = .초성(val)
  }

  init(_ val: 종성) {
    self = .종성(val)
  }

  init(_ val: 모음) {
    self = .모음(val)
  }
}
