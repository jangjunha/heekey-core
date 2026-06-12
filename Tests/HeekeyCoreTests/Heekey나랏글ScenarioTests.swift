import Testing

@testable import HeekeyCore

/// 실제 키 입력 시퀀스를 따라가며 화면에 표시되는 문자열을 검증하는 종단 테스트.
///
/// 각 단계에서 `dispatch`를 적용한 뒤 `emitted + state.string`이 기대 문자열과
/// 일치하는지 확인합니다.
@Suite struct Heekey나랏글ScenarioTests {
  typealias State = Heekey나랏글State
  typealias Action = Heekey나랏글Action

  /// 키 입력 시퀀스를 순서대로 적용하고 최종 표시 문자열을 반환합니다.
  private func type(_ actions: [Action], from state: State = .init(tokens: [])) -> String {
    var state = state
    var emitted = ""
    for action in actions {
      let (str, next) = state.dispatch(action: action)
      emitted += str
      state = next
    }
    return emitted + state.string
  }

  @Test func test받침이동() {
    // 갓 + ㅏ → 가사
    #expect(
      type([.조합문자(.ㄱ), .조합문자(.ㅏㅓ), .조합문자(.ㅅ)]) == "갓")
    #expect(
      type([.조합문자(.ㄱ), .조합문자(.ㅏㅓ), .조합문자(.ㅅ), .조합문자(.ㅏㅓ)]) == "가사")
  }

  @Test func test겹받침완성() {
    // 안 + ㅅ + 획추가 → 앉 (ㅈ = ㅅ + 획추가)
    let 안ㅅ: [Action] = [.조합문자(.ㅇ), .조합문자(.ㅏㅓ), .조합문자(.ㄴ), .조합문자(.ㅅ)]
    #expect(type(안ㅅ) == "안ㅅ")
    #expect(type(안ㅅ + [.기능(.획추가)]) == "앉")
    // 앉 + ㅡ + 모음이면 ㅈ이 초성으로 이동
    #expect(type(안ㅅ + [.기능(.획추가), .조합문자(.ㅏㅓ)]) == "안자")
  }

  @Test func test쌍자음종성() {
    // 갔어: ㄱ ㅏ ㅅ 쌍자음 ㅇ ㅓ
    let 갔: [Action] = [.조합문자(.ㄱ), .조합문자(.ㅏㅓ), .조합문자(.ㅅ), .기능(.쌍자음)]
    #expect(type(갔) == "갔")
    #expect(type(갔 + [.조합문자(.ㅇ), .조합문자(.ㅏㅓ), .조합문자(.ㅏㅓ)]) == "갔어")
    // 갔 + 모음 → 쌍자음이 초성으로 이동
    #expect(type(갔 + [.조합문자(.ㅏㅓ)]) == "가싸")
  }

  @Test func test모음회전() {
    #expect(type([.조합문자(.ㄱ), .조합문자(.ㅏㅓ), .조합문자(.ㅏㅓ)]) == "거")
    #expect(type([.조합문자(.ㄱ), .조합문자(.ㅗㅜ), .조합문자(.ㅗㅜ)]) == "구")
    // ㅝ: ㅜ 상태에서 ㅏㅓ를 누르면 바로 ㅓ가 추가됨
    #expect(type([.조합문자(.ㄱ), .조합문자(.ㅗㅜ), .조합문자(.ㅗㅜ), .조합문자(.ㅏㅓ)]) == "궈")
  }

  @Test func test복합모음() {
    // 왜: ㅇ ㅗ ㅏ ㅣ
    #expect(
      type([.조합문자(.ㅇ), .조합문자(.ㅗㅜ), .조합문자(.ㅏㅓ), .조합문자(.ㅣ)]) == "왜")
    // 의: ㅇ ㅡ ㅣ
    #expect(type([.조합문자(.ㅇ), .조합문자(.ㅡ), .조합문자(.ㅣ)]) == "의")
  }

  @Test func test초성없는모음과종성() {
    // 초성 없이 모음 + 자음을 입력하면 호환 자모로 표시되어야 한다.
    // (결합 종성 자모 U+11xx가 그대로 노출되면 렌더링이 깨진다 — regression)
    #expect(type([.조합문자(.ㅏㅓ), .조합문자(.ㄴ)]) == "ㅏㄴ")
    #expect(type([.조합문자(.ㅡ), .조합문자(.ㄴ)]) == "ㅡㄴ")
    #expect(
      type([.조합문자(.ㄱ), .조합문자(.ㅏㅓ), .조합문자(.ㅡ), .조합문자(.ㄴ)]) == "가ㅡㄴ")
    // 겹받침 형태의 단독 종성도 호환 자모로 풀려야 한다
    #expect(
      type([.조합문자(.ㅏㅓ), .조합문자(.ㄴ), .조합문자(.ㅅ), .기능(.획추가)]) == "ㅏㄵ")
  }

  @Test func test다음절() {
    // 나랏글: ㄴ ㅏ ㄹ ㅏ 획추가(ㄹ→무시 아님; ㅅ→ㅈ 케이스와 달리 ㄷ) …
    // 단순 다음절 시나리오: 가나다
    #expect(
      type([
        .조합문자(.ㄱ), .조합문자(.ㅏㅓ),
        .조합문자(.ㄴ), .조합문자(.ㅏㅓ),
        .조합문자(.ㄴ), .기능(.획추가), .조합문자(.ㅏㅓ),
      ]) == "가나다")
  }

  @Test func test백스페이스() {
    // 가나 → backspace → 간
    #expect(
      type([
        .조합문자(.ㄱ), .조합문자(.ㅏㅓ), .조합문자(.ㄴ), .조합문자(.ㅏㅓ), .기능(.backspace),
      ]) == "간")
    // 앉 → backspace → 안
    #expect(
      type([
        .조합문자(.ㅇ), .조합문자(.ㅏㅓ), .조합문자(.ㄴ), .조합문자(.ㅅ), .기능(.획추가),
        .기능(.backspace),
      ]) == "안")
  }
}
