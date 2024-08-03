public enum Action: Equatable {
  case 완성문자(String)
  case 조합문자(조합문자)
  case 기능(기능)
}

public enum 조합문자: Equatable {
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

public enum 기능: Equatable {
  case 획추가
  case 쌍자음
  case backspace
}
