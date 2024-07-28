public enum Symbol {
  case 초성(초성)
  case 중성(중성)
  case 종성(종성)
}

public enum 초성 {
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

public enum 중성 {
  case ㅏ  // ㅏ
  case ㅐ  // ㅏ ㅣ
  case ㅑ  // ㅏ 획
  case ㅒ  // ㅏ 획 ㅣ
  case ㅓ  // ㅏ ㅏ
  case ㅔ  // ㅏ ㅏ ㅣ
  case ㅕ  // ㅏ ㅏ 획
  case ㅖ  // ㅏ ㅏ 획 ㅣ
  case ㅗ  // ㅗ
  case ㅘ  // ㅗ ㅏ
  case ㅙ  // ㅗ ㅏ ㅣ
  case ㅚ  // ㅗ ㅣ
  case ㅛ  // ㅗ 획
  case ㅜ  // ㅗ ㅗ
  case ㅝ  // ㅗ ㅗ ㅏ
  case ㅞ  // ㅗ ㅗ ㅏ ㅣ
  case ㅟ  // ㅗ ㅗ ㅣ
  case ㅠ  // ㅗ ㅗ 획
  case ㅡ  // ㅡ
  case ㅢ  // ㅡ ㅣ
  case ㅣ  // ㅣ
}

public enum 종성 {
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

extension Symbol: Equatable {}

extension Symbol {
  public init(_ value: 초성) {
    self = .초성(value)
  }

  public init(_ value: 중성) {
    self = .중성(value)
  }

  public init(_ value: 종성) {
    self = .종성(value)
  }
}

extension Symbol {
  var char: Character {
    switch self {
    case let .초성(v): return v.char
    case let .중성(v): return v.char
    case let .종성(v): return v.char
    }
  }
}

extension 초성 {
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

extension 중성 {
  var char: Character {
    switch self {
    case .ㅏ: return "\u{1161}"
    case .ㅐ: return "\u{1162}"
    case .ㅑ: return "\u{1163}"
    case .ㅒ: return "\u{1164}"
    case .ㅓ: return "\u{1165}"
    case .ㅔ: return "\u{1166}"
    case .ㅕ: return "\u{1167}"
    case .ㅖ: return "\u{1168}"
    case .ㅗ: return "\u{1169}"
    case .ㅘ: return "\u{116A}"
    case .ㅙ: return "\u{116B}"
    case .ㅚ: return "\u{116C}"
    case .ㅛ: return "\u{116D}"
    case .ㅜ: return "\u{116E}"
    case .ㅝ: return "\u{116F}"
    case .ㅞ: return "\u{1170}"
    case .ㅟ: return "\u{1171}"
    case .ㅠ: return "\u{1172}"
    case .ㅡ: return "\u{1173}"
    case .ㅢ: return "\u{1174}"
    case .ㅣ: return "\u{1175}"
    }
  }
}

extension 종성 {
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
