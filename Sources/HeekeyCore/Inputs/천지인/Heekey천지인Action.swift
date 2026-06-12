public enum Heekey천지인Action: Equatable {
  case 완성문자(String)
  /// `연속입력`: 같은 키를 짧은 시간 안에 다시 눌렀는지 여부.
  /// 자음 키의 멀티탭 순환(ㄱ→ㅋ→ㄲ)은 연속입력일 때만 동작합니다.
  /// 타이밍 판단은 뷰 컨트롤러의 책임입니다.
  case 조합문자(Heekey천지인조합문자, 연속입력: Bool)
  case 기능(Heekey천지인기능)
}

public enum Heekey천지인조합문자: Equatable {
  case ㄱㅋ
  case ㄴㄹ
  case ㄷㅌ
  case ㅂㅍ
  case ㅅㅎ
  case ㅈㅊ
  case ㅇㅁ
  case ㅣ
  case 천
  case ㅡ
}

public enum Heekey천지인기능: Equatable {
  case backspace
}
