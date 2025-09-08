public enum Heekey천지인Action: Equatable {
  case 완성문자(String)
  case 조합문자(Heekey천지인조합문자)
  case 기능(Heekey천지인기능)
}

public enum Heekey천지인조합문자: Equatable {
  case ㅣ
  case ㆍ
  case ㅡ
  case ㄱㅋ
  case ㄴㄹ
  case ㄷㅌ
  case ㅂㅍ
  case ㅅㅎ
  case ㅈㅊ
  case ㅇㅁ
  case specialChars  // .,?!
}

extension Heekey천지인조합문자 {
  var firstToken: Heekey천지인Token {
    switch self {
      case .ㅣ: return .모음(.ㅣ)
      case .ㆍ: return .모음(.ㆍ)
      case .ㅡ: return .모음(.ㅡ)
      case .ㄱㅋ: return .자음(.ㄱ)
      case .ㄴㄹ: return .자음(.ㄴ)
      case .ㄷㅌ: return .자음(.ㄷ)
      case .ㅂㅍ: return .자음(.ㅂ)
      case .ㅅㅎ: return .자음(.ㅅ)
      case .ㅈㅊ: return .자음(.ㅈ)
      case .ㅇㅁ: return .자음(.ㅇ)
      case .specialChars: return .punctuations(.dot)
    }
  }
}

public enum Heekey천지인기능: Equatable {
  case backspace
  case complete
}
