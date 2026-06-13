/// 조합 상태 변화를 문서에 반영하기 위한 최소 편집(뒤에서 n글자 삭제 후 입력).
///
/// 키보드는 조합 중인 문자열을 문서 끝에 그대로 입력해 두므로, 상태가 바뀌면
/// "이전 표시 문자열 → 새 표시 문자열"의 공통 접두사를 보존하고 나머지만
/// 삭제·재입력한다.
public struct CompositionPatch: Equatable {
  /// 문서 끝에서 지워야 할 글자 수
  public let deleteCount: Int
  /// 지운 뒤 입력할 문자열
  public let insert: String

  public init(deleteCount: Int, insert: String) {
    self.deleteCount = deleteCount
    self.insert = insert
  }

  /// 문서 끝에 `current`가 입력되어 있다고 가정하고, 문서가 `objective`로
  /// 끝나게 만드는 패치를 계산한다.
  public static func between(current: String, objective: String) -> CompositionPatch {
    let preserves = zip(current, objective).prefix(while: { $0 == $1 }).count
    return .init(
      deleteCount: current.count - preserves,
      insert: String(objective.dropFirst(preserves))
    )
  }
}
