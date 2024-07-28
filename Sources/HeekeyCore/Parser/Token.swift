/// 지워지는 단위
public enum Token {
  case 자음(자음)
  case 모음(모음)
}

public enum 자음 {
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

public enum 모음 {
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

extension Token {
  public init(_ value: 자음) {
    self = .자음(value)
  }

  public init(_ value: 모음) {
    self = .모음(value)
  }
}
