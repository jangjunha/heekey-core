enum 중성Symbol {
  case ㅏ
  case ㅐ
  case ㅑ
  case ㅒ
  case ㅓ
  case ㅔ
  case ㅕ
  case ㅖ
  case ㅗ
  case ㅘ
  case ㅙ
  case ㅚ
  case ㅛ
  case ㅜ
  case ㅝ
  case ㅞ
  case ㅟ
  case ㅠ
  case ㅡ
  case ㅢ
  case ㅣ
}

extension 중성Symbol {
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
