public enum Heekey나랏글Action: Equatable {
  case 완성문자(String)
  case 조합문자(Heekey나랏글조합문자)
  case 기능(Heekey나랏글기능)
}

public enum Heekey나랏글조합문자: Equatable {
  case ㄱ
  case ㄴ
  case ㄹ
  case ㅁ
  case ㅅ
  case ㅇ
  case ㅏㅓ
  case ㅗㅜ
  case ㅣ
  case ㅡ
}

public enum Heekey나랏글기능: Equatable {
  case 획추가
  case 쌍자음
  case backspace
}
