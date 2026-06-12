/// Erasible Unit
public enum Heekey천지인Token: Equatable, Hashable {
  case 자음(Heekey천지인자음)
  case 모음요소(Heekey천지인모음요소)
}

public enum Heekey천지인자음: Equatable, Hashable {
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

/// 천지인 모음의 구성 요소.
///
/// 천(ㆍ), 지(ㅡ), 인(ㅣ) 세 요소의 나열로 모든 중성을 표현합니다.
public enum Heekey천지인모음요소: Equatable, Hashable {
  case ㅣ
  case 천  // ㆍ
  case ㅡ
}

public extension Heekey천지인Token {
  init(_ value: Heekey천지인자음) {
    self = .자음(value)
  }

  init(_ value: Heekey천지인모음요소) {
    self = .모음요소(value)
  }
}
