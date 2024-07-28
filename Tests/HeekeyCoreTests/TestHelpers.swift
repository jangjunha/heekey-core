import HeekeyCore

func char_to_token(_ ch: Character) -> Token {
  switch ch {
  case "ㄱ": return .init(자음.ㄱ)
  case "ㄲ": return .init(자음.ㄱㄱ)
  case "ㄴ": return .init(자음.ㄴ)
  case "ㄷ": return .init(자음.ㄷ)
  case "ㄸ": return .init(자음.ㄷㄷ)
  case "ㄹ": return .init(자음.ㄹ)
  case "ㅁ": return .init(자음.ㅁ)
  case "ㅂ": return .init(자음.ㅂ)
  case "ㅃ": return .init(자음.ㅂㅂ)
  case "ㅅ": return .init(자음.ㅅ)
  case "ㅆ": return .init(자음.ㅅㅅ)
  case "ㅇ": return .init(자음.ㅇ)
  case "ㅈ": return .init(자음.ㅈ)
  case "ㅉ": return .init(자음.ㅈㅈ)
  case "ㅊ": return .init(자음.ㅊ)
  case "ㅋ": return .init(자음.ㅋ)
  case "ㅌ": return .init(자음.ㅌ)
  case "ㅍ": return .init(자음.ㅍ)
  case "ㅎ": return .init(자음.ㅎ)
  case "ㅏ": return .init(모음.ㅏ)
  case "ㅑ": return .init(모음.ㅑ)
  case "ㅓ": return .init(모음.ㅓ)
  case "ㅕ": return .init(모음.ㅕ)
  case "ㅗ": return .init(모음.ㅗ)
  case "ㅛ": return .init(모음.ㅛ)
  case "ㅜ": return .init(모음.ㅜ)
  case "ㅠ": return .init(모음.ㅠ)
  case "ㅡ": return .init(모음.ㅡ)
  case "ㅣ": return .init(모음.ㅣ)
  case _: fatalError("Unsupported ch '\(ch)'")
  }
}

func str_to_tokens(_ str: String) -> [Token] {
  return str.map(char_to_token)
}
