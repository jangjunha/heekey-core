public enum Heekey두벌식Action: Equatable {
  case 완성문자(String)
  case 조합문자(Heekey두벌식조합문자)
  case 기능(Heekey두벌식기능)
}

public enum Heekey두벌식조합문자: Equatable {
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

extension Heekey두벌식조합문자 {
  var token: Heekey두벌식Token {
    switch self {
    case .ㄱ: return .자음(.ㄱ)
    case .ㄱㄱ: return .자음(.ㄱㄱ)
    case .ㄴ: return .자음(.ㄴ)
    case .ㄷ: return .자음(.ㄷ)
    case .ㄷㄷ: return .자음(.ㄷㄷ)
    case .ㄹ: return .자음(.ㄹ)
    case .ㅁ: return .자음(.ㅁ)
    case .ㅂ: return .자음(.ㅂ)
    case .ㅂㅂ: return .자음(.ㅂㅂ)
    case .ㅅ: return .자음(.ㅅ)
    case .ㅅㅅ: return .자음(.ㅅㅅ)
    case .ㅇ: return .자음(.ㅇ)
    case .ㅈ: return .자음(.ㅈ)
    case .ㅈㅈ: return .자음(.ㅈㅈ)
    case .ㅊ: return .자음(.ㅊ)
    case .ㅋ: return .자음(.ㅋ)
    case .ㅌ: return .자음(.ㅌ)
    case .ㅍ: return .자음(.ㅍ)
    case .ㅎ: return .자음(.ㅎ)
    case .ㅏ: return .모음(.ㅏ)
    case .ㅐ: return .모음(.ㅐ)
    case .ㅑ: return .모음(.ㅑ)
    case .ㅒ: return .모음(.ㅒ)
    case .ㅓ: return .모음(.ㅓ)
    case .ㅔ: return .모음(.ㅔ)
    case .ㅕ: return .모음(.ㅕ)
    case .ㅖ: return .모음(.ㅖ)
    case .ㅗ: return .모음(.ㅗ)
    case .ㅛ: return .모음(.ㅛ)
    case .ㅜ: return .모음(.ㅜ)
    case .ㅠ: return .모음(.ㅠ)
    case .ㅡ: return .모음(.ㅡ)
    case .ㅣ: return .모음(.ㅣ)
    }
  }
}

public enum Heekey두벌식기능: Equatable {
  case backspace
  case emit  // nop but emit state
}
