enum 종성Symbol {
  case ㄱ
  case ㄱㄱ
  case ㄱㅅ
  case ㄴ
  case ㄴㅈ
  case ㄴㅎ
  case ㄷ
  case ㄹ
  case ㄹㄱ
  case ㄹㅁ
  case ㄹㅂ
  case ㄹㅅ
  case ㄹㅌ
  case ㄹㅍ
  case ㄹㅎ
  case ㅁ
  case ㅂ
  case ㅂㅅ
  case ㅅ
  case ㅅㅅ
  case ㅇ
  case ㅈ
  case ㅊ
  case ㅋ
  case ㅌ
  case ㅍ
  case ㅎ
}

extension 종성Symbol {
  var char: Character {
    switch self {
    case .ㄱ: return "\u{11A8}"
    case .ㄱㄱ: return "\u{11A9}"
    case .ㄱㅅ: return "\u{11AA}"
    case .ㄴ: return "\u{11AB}"
    case .ㄴㅈ: return "\u{11AC}"
    case .ㄴㅎ: return "\u{11AD}"
    case .ㄷ: return "\u{11AE}"
    case .ㄹ: return "\u{11AF}"
    case .ㄹㄱ: return "\u{11B0}"
    case .ㄹㅁ: return "\u{11B1}"
    case .ㄹㅂ: return "\u{11B2}"
    case .ㄹㅅ: return "\u{11B3}"
    case .ㄹㅌ: return "\u{11B4}"
    case .ㄹㅍ: return "\u{11B5}"
    case .ㄹㅎ: return "\u{11B6}"
    case .ㅁ: return "\u{11B7}"
    case .ㅂ: return "\u{11B8}"
    case .ㅂㅅ: return "\u{11B9}"
    case .ㅅ: return "\u{11BA}"
    case .ㅅㅅ: return "\u{11BB}"
    case .ㅇ: return "\u{11BC}"
    case .ㅈ: return "\u{11BD}"
    case .ㅊ: return "\u{11BE}"
    case .ㅋ: return "\u{11BF}"
    case .ㅌ: return "\u{11C0}"
    case .ㅍ: return "\u{11C1}"
    case .ㅎ: return "\u{11C2}"
    }
  }
}
