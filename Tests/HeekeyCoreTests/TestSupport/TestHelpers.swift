import HeekeyCore

func char_to_나랏글token(_ ch: Character) -> Heekey나랏글Token {
  typealias 자음 = Heekey나랏글자음
  typealias 모음 = Heekey나랏글모음
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

func str_to_나랏글tokens(_ str: String) -> [Heekey나랏글Token] {
  return str.map(char_to_나랏글token)
}

func char_to_두벌식token(_ ch: Character) -> Heekey두벌식Token {
  typealias 자음 = Heekey두벌식자음
  typealias 모음 = Heekey두벌식모음
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
  case "ㅐ": return .init(모음.ㅐ)
  case "ㅑ": return .init(모음.ㅑ)
  case "ㅒ": return .init(모음.ㅒ)
  case "ㅓ": return .init(모음.ㅓ)
  case "ㅔ": return .init(모음.ㅔ)
  case "ㅕ": return .init(모음.ㅕ)
  case "ㅖ": return .init(모음.ㅖ)
  case "ㅗ": return .init(모음.ㅗ)
  case "ㅛ": return .init(모음.ㅛ)
  case "ㅜ": return .init(모음.ㅜ)
  case "ㅠ": return .init(모음.ㅠ)
  case "ㅡ": return .init(모음.ㅡ)
  case "ㅣ": return .init(모음.ㅣ)
  case _: fatalError("Unsupported ch '\(ch)'")
  }
}

func str_to_두벌식tokens(_ str: String) -> [Heekey두벌식Token] {
  return str.map(char_to_두벌식token)
}

func char_to_천지인token(_ ch: Character) -> Heekey천지인Token {
  typealias 자음 = Heekey천지인자음
  typealias 모음 = Heekey천지인모음
  typealias 특수 = Heekey천지인Punctuations
  switch ch {
  case "ㄱ": return Heekey천지인Token.자음(자음.ㄱ)
  case "ㄲ": return Heekey천지인Token.자음(자음.ㄱㄱ)
  case "ㄴ": return Heekey천지인Token.자음(자음.ㄴ)
  case "ㄷ": return Heekey천지인Token.자음(자음.ㄷ)
  case "ㄸ": return Heekey천지인Token.자음(자음.ㄷㄷ)
  case "ㄹ": return Heekey천지인Token.자음(자음.ㄹ)
  case "ㅁ": return Heekey천지인Token.자음(자음.ㅁ)
  case "ㅂ": return Heekey천지인Token.자음(자음.ㅂ)
  case "ㅃ": return Heekey천지인Token.자음(자음.ㅂㅂ)
  case "ㅅ": return Heekey천지인Token.자음(자음.ㅅ)
  case "ㅆ": return Heekey천지인Token.자음(자음.ㅅㅅ)
  case "ㅇ": return Heekey천지인Token.자음(자음.ㅇ)
  case "ㅈ": return Heekey천지인Token.자음(자음.ㅈ)
  case "ㅉ": return Heekey천지인Token.자음(자음.ㅈㅈ)
  case "ㅊ": return Heekey천지인Token.자음(자음.ㅊ)
  case "ㅋ": return Heekey천지인Token.자음(자음.ㅋ)
  case "ㅌ": return Heekey천지인Token.자음(자음.ㅌ)
  case "ㅍ": return Heekey천지인Token.자음(자음.ㅍ)
  case "ㅎ": return Heekey천지인Token.자음(자음.ㅎ)
  case "ㆍ": return Heekey천지인Token.모음(모음.ㆍ)
  case "ㅡ": return Heekey천지인Token.모음(모음.ㅡ)
  case "ㅣ": return Heekey천지인Token.모음(모음.ㅣ)
  case ".": return Heekey천지인Token.punctuations(특수.dot)
  case ",": return Heekey천지인Token.punctuations(특수.comma)
  case "?": return Heekey천지인Token.punctuations(특수.questionMark)
  case "!": return Heekey천지인Token.punctuations(특수.exclamationMark)
  case _: fatalError("Unsupported ch '\(ch)'")
  }
}

func str_to_천지인tokens(_ str: String) -> [Heekey천지인Token] {
  return str.map(char_to_천지인token)
}
