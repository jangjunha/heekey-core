/// 천지인 파서의 최종 출력 기호.
///
/// 아직 중성으로 완성되지 않은 ㆍ, ㆍㆍ를 표현하기 위해 `Symbol`을 확장합니다.
enum 천지인Symbol: Equatable {
  case symbol(Symbol)
  /// 조합 중인 천(ㆍ). count는 1 또는 2.
  case 천(Int)
}

extension 천지인Symbol {
  var char: Character {
    switch self {
    case .symbol(let s): return s.char
    case .천(1): return "\u{318D}"  // ㆍ
    case .천: return "\u{2025}"  // ‥
    }
  }
}

enum 천지인PostParser {
  /// 모음 요소를 중성으로 조합하고 받침(겹받침)을 조합합니다.

  typealias Input = TypeA자음PreParserOutputToken<Heekey천지인모음요소>

  static func parse<S: Sequence>(tokens: S) -> [천지인Symbol] where S.Element == Input {
    var outputs = [천지인Symbol]()
    var 모음상태: 모음조합상태? = nil

    func flush모음() {
      if let state = 모음상태 {
        outputs.append(state.symbol)
        모음상태 = nil
      }
    }

    for token in tokens {
      switch token {
      case .모음(let element):
        if let state = 모음상태 {
          if let next = state.조합(element) {
            모음상태 = next
          } else {
            // 더 이상 조합할 수 없으면 확정하고 새 모음을 시작
            outputs.append(state.symbol)
            모음상태 = .init(element)
          }
        } else {
          모음상태 = .init(element)
        }

      case .초성(let v):
        flush모음()
        outputs.append(.symbol(.초성(.init(from: v))))

      case .종성(let v):
        flush모음()
        // 겹받침 조합
        if case .symbol(.종성(let prev)) = outputs.last,
          let merged = 겹받침(prev, v)
        {
          outputs.removeLast()
          outputs.append(.symbol(.종성(merged)))
        } else {
          outputs.append(.symbol(.종성(.init(from: v))))
        }
      }
    }
    flush모음()
    return outputs
  }

  private static func 겹받침(_ first: 종성Symbol, _ second: TypeA자음Token) -> 종성Symbol? {
    switch (first, second) {
    case (.ㄱ, .ㅅ): return .ㄱㅅ
    case (.ㄴ, .ㅈ): return .ㄴㅈ
    case (.ㄴ, .ㅎ): return .ㄴㅎ
    case (.ㄹ, .ㄱ): return .ㄹㄱ
    case (.ㄹ, .ㅁ): return .ㄹㅁ
    case (.ㄹ, .ㅂ): return .ㄹㅂ
    case (.ㄹ, .ㅅ): return .ㄹㅅ
    case (.ㄹ, .ㅌ): return .ㄹㅌ
    case (.ㄹ, .ㅍ): return .ㄹㅍ
    case (.ㄹ, .ㅎ): return .ㄹㅎ
    case (.ㅂ, .ㅅ): return .ㅂㅅ
    default: return nil
    }
  }
}

/// 천지인 모음 조합 오토마타.
///
/// ㅣ·ㆍ·ㅡ의 나열을 중성으로 점진 조합합니다. 예: ㅣ→ㅏ(ㅣㆍ)→ㅑ(ㅣㆍㆍ)→ㅒ(ㅣㆍㆍㅣ)
fileprivate enum 모음조합상태: Equatable {
  case 천
  case 천천
  case 중성(중성Symbol)

  init(_ element: Heekey천지인모음요소) {
    switch element {
    case .ㅣ: self = .중성(.ㅣ)
    case .천: self = .천
    case .ㅡ: self = .중성(.ㅡ)
    }
  }

  func 조합(_ element: Heekey천지인모음요소) -> Self? {
    switch (self, element) {
    case (.천, .ㅣ): return .중성(.ㅓ)
    case (.천, .ㅡ): return .중성(.ㅗ)
    case (.천, .천): return .천천
    case (.천천, .ㅣ): return .중성(.ㅕ)
    case (.천천, .ㅡ): return .중성(.ㅛ)
    case (.중성(.ㅣ), .천): return .중성(.ㅏ)
    case (.중성(.ㅏ), .천): return .중성(.ㅑ)
    case (.중성(.ㅏ), .ㅣ): return .중성(.ㅐ)
    case (.중성(.ㅑ), .ㅣ): return .중성(.ㅒ)
    case (.중성(.ㅓ), .ㅣ): return .중성(.ㅔ)
    case (.중성(.ㅕ), .ㅣ): return .중성(.ㅖ)
    case (.중성(.ㅗ), .ㅣ): return .중성(.ㅚ)
    case (.중성(.ㅚ), .천): return .중성(.ㅘ)
    case (.중성(.ㅘ), .ㅣ): return .중성(.ㅙ)
    case (.중성(.ㅡ), .천): return .중성(.ㅜ)
    case (.중성(.ㅡ), .ㅣ): return .중성(.ㅢ)
    case (.중성(.ㅜ), .ㅣ): return .중성(.ㅟ)
    case (.중성(.ㅜ), .천): return .중성(.ㅠ)
    case (.중성(.ㅠ), .ㅣ): return .중성(.ㅝ)
    case (.중성(.ㅝ), .ㅣ): return .중성(.ㅞ)
    default: return nil
    }
  }

  var symbol: 천지인Symbol {
    switch self {
    case .천: return .천(1)
    case .천천: return .천(2)
    case .중성(let v): return .symbol(.중성(v))
    }
  }
}

fileprivate extension 초성Symbol {
  init(from: TypeA자음Token) {
    switch from {
    case .ㄱ: self = .ㄱ
    case .ㄱㄱ: self = .ㄱㄱ
    case .ㄴ: self = .ㄴ
    case .ㄷ: self = .ㄷ
    case .ㄷㄷ: self = .ㄷㄷ
    case .ㄹ: self = .ㄹ
    case .ㅁ: self = .ㅁ
    case .ㅂ: self = .ㅂ
    case .ㅂㅂ: self = .ㅂㅂ
    case .ㅅ: self = .ㅅ
    case .ㅅㅅ: self = .ㅅㅅ
    case .ㅇ: self = .ㅇ
    case .ㅈ: self = .ㅈ
    case .ㅈㅈ: self = .ㅈㅈ
    case .ㅊ: self = .ㅊ
    case .ㅋ: self = .ㅋ
    case .ㅌ: self = .ㅌ
    case .ㅍ: self = .ㅍ
    case .ㅎ: self = .ㅎ
    }
  }
}

fileprivate extension 종성Symbol {
  init(from: TypeA자음Token) {
    switch from {
    case .ㄱ: self = .ㄱ
    case .ㄱㄱ: self = .ㄱㄱ
    case .ㄴ: self = .ㄴ
    case .ㄷ: self = .ㄷ
    case .ㄹ: self = .ㄹ
    case .ㅁ: self = .ㅁ
    case .ㅂ: self = .ㅂ
    case .ㅅ: self = .ㅅ
    case .ㅅㅅ: self = .ㅅㅅ
    case .ㅇ: self = .ㅇ
    case .ㅈ: self = .ㅈ
    case .ㅊ: self = .ㅊ
    case .ㅋ: self = .ㅋ
    case .ㅌ: self = .ㅌ
    case .ㅍ: self = .ㅍ
    case .ㅎ: self = .ㅎ
    case .ㄷㄷ, .ㅂㅂ, .ㅈㅈ:
      assertionFailure("종성이 될 수 없음: \(from)")
      self = .ㄷ
    }
  }
}
