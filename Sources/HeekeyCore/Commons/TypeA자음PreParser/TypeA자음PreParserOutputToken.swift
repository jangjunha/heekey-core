enum TypeA자음PreParserOutputToken<T: Equatable, U: Equatable>: Equatable {
  case 초성(TypeA자음Token)
  case 종성(TypeA자음Token)
  case 모음(T)
  case other(U)
}
