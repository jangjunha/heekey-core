extension Character {
  public var 한글완성형: [Character] {
    self.unicodeScalars.map {
      switch $0 {
      case "\u{1100}": return "ㄱ"
      case "\u{1101}": return "ㄲ"
      case "\u{1102}": return "ㄴ"
      case "\u{1103}": return "ㄷ"
      case "\u{1104}": return "ㄸ"
      case "\u{1105}": return "ㄹ"
      case "\u{1106}": return "ㅁ"
      case "\u{1107}": return "ㅂ"
      case "\u{1108}": return "ㅃ"
      case "\u{1109}": return "ㅅ"
      case "\u{110A}": return "ㅆ"
      case "\u{110B}": return "ㅇ"
      case "\u{110C}": return "ㅈ"
      case "\u{110D}": return "ㅉ"
      case "\u{110E}": return "ㅊ"
      case "\u{110F}": return "ㅋ"
      case "\u{1110}": return "ㅌ"
      case "\u{1111}": return "ㅍ"
      case "\u{1112}": return "ㅎ"
      case "\u{1161}":	return "ㅏ"
      case "\u{1162}":	return "ㅐ"
      case "\u{1163}":	return "ㅑ"
      case "\u{1164}":	return "ㅒ"
      case "\u{1165}":	return "ㅓ"
      case "\u{1166}":	return "ㅔ"
      case "\u{1167}":	return "ㅕ"
      case "\u{1168}":	return "ㅖ"
      case "\u{1169}":	return "ㅗ"
      case "\u{116A}":	return "ㅘ"
      case "\u{116B}":	return "ㅙ"
      case "\u{116C}":	return "ㅚ"
      case "\u{116D}":	return "ㅛ"
      case "\u{116E}":	return "ㅜ"
      case "\u{116F}":	return "ㅝ"
      case "\u{1170}":	return "ㅞ"
      case "\u{1171}":	return "ㅟ"
      case "\u{1172}":	return "ㅠ"
      case "\u{1173}":	return "ㅡ"
      case "\u{1174}":	return "ㅢ"
      case "\u{1175}":	return "ㅣ"
      default: return Character($0)
      }
    }
  }
}
