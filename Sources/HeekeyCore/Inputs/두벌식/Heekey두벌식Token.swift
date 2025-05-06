public enum Heekey두벌식Token: Equatable {
  case 자음(Heekey두벌식자음)
  case 모음(Heekey두벌식모음)
}

public enum Heekey두벌식자음: Equatable {
  case ㄱ
  case ㄱㄱ
  case ㄴ
  case ㄷ
  case ㄷㄷ
  case ㄹ
  case ㅁ
  case ㅂ
  case ㅂㅂ
  case ㅅ
  case ㅅㅅ
  case ㅇ
  case ㅈ
  case ㅈㅈ
  case ㅊ
  case ㅋ
  case ㅌ
  case ㅍ
  case ㅎ
}

public enum Heekey두벌식모음: Equatable {
  case ㅏ
  case ㅐ
  case ㅑ
  case ㅒ
  case ㅓ
  case ㅔ
  case ㅕ
  case ㅖ
  case ㅗ
  case ㅛ
  case ㅜ
  case ㅠ
  case ㅡ
  case ㅣ
}

public extension Heekey두벌식Token {
  init(_ value: Heekey두벌식자음) {
    self = .자음(value)
  }

  init(_ value: Heekey두벌식모음) {
    self = .모음(value)
  }
}
