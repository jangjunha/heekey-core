/// Erasible Unit
public enum Heekey나랏글Token: Equatable, Hashable {
  case 자음(Heekey나랏글자음)
  case 모음(Heekey나랏글모음)
}

public enum Heekey나랏글자음: Equatable, Hashable {
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

public enum Heekey나랏글모음: Equatable, Hashable {
  case ㅏ  // ㅏ
  case ㅑ  // ㅏ 획
  case ㅓ  // ㅏ ㅏ
  case ㅕ  // ㅏ ㅏ 획
  case ㅗ  // ㅗ
  case ㅛ  // ㅗ 획
  case ㅜ  // ㅗ ㅗ
  case ㅠ  // ㅗ ㅗ 획
  case ㅡ  // ㅡ
  case ㅣ  // ㅣ
}

public extension Heekey나랏글Token {
  init(_ value: Heekey나랏글자음) {
    self = .자음(value)
  }

  init(_ value: Heekey나랏글모음) {
    self = .모음(value)
  }
}
