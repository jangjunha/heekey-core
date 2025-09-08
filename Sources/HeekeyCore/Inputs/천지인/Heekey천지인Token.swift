public enum Heekey천지인Token: Equatable {
  case 자음(Heekey천지인자음)
  case 모음(Heekey천지인모음)
  case punctuations(Heekey천지인Punctuations)
}

public enum Heekey천지인자음: Equatable {
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

public enum Heekey천지인모음: Equatable {
  case ㆍ
  case ㅡ
  case ㅣ
}

public enum Heekey천지인Punctuations: Equatable {
  case dot
  case comma
  case questionMark
  case exclamationMark
}
