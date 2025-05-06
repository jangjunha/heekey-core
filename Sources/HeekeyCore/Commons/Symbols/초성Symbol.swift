enum 초성Symbol {
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

extension 초성Symbol {
  var char: Character {
    switch self {
    case .ㄱ: return "\u{1100}"
    case .ㄱㄱ: return "\u{1101}"
    case .ㄴ: return "\u{1102}"
    case .ㄷ: return "\u{1103}"
    case .ㄷㄷ: return "\u{1104}"
    case .ㄹ: return "\u{1105}"
    case .ㅁ: return "\u{1106}"
    case .ㅂ: return "\u{1107}"
    case .ㅂㅂ: return "\u{1108}"
    case .ㅅ: return "\u{1109}"
    case .ㅅㅅ: return "\u{110A}"
    case .ㅇ: return "\u{110B}"
    case .ㅈ: return "\u{110C}"
    case .ㅈㅈ: return "\u{110D}"
    case .ㅊ: return "\u{110E}"
    case .ㅋ: return "\u{110F}"
    case .ㅌ: return "\u{1110}"
    case .ㅍ: return "\u{1111}"
    case .ㅎ: return "\u{1112}"
    }
  }
}
