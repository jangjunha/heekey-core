import Testing

@testable import HeekeyCore

@Suite struct CompositionPatchTests {
  @Test(arguments: [
    // (current, objective, deleteCount, insert)
    ("", "", 0, ""),
    ("", "가", 0, "가"),
    ("가", "가", 0, ""),
    ("가", "", 1, ""),
    ("가", "각", 1, "각"),
    ("갓", "가사", 1, "가사"),
    ("가", "가.", 0, "."),
    ("간ㅅ", "안ㅈ", 2, "안ㅈ"),
    ("가나", "간", 2, "간"),
  ]) func testBetween(arg: (String, String, Int, String)) {
    let (current, objective, deleteCount, insert) = arg
    let patch = CompositionPatch.between(current: current, objective: objective)
    #expect(patch == CompositionPatch(deleteCount: deleteCount, insert: insert))
  }

  /// 패치를 문서에 적용하면 항상 objective로 끝나야 한다.
  @Test func testRoundTrip() {
    let samples = ["", "가", "갓", "가나", "안ㅅ", "앉", "값", "ㅏㄴ", "가ㅡㄴ", "구ㅏ", "궈"]
    for current in samples {
      for objective in samples {
        let doc = "이전텍스트" + current
        let patch = CompositionPatch.between(current: current, objective: objective)
        let applied = String(doc.dropLast(patch.deleteCount)) + patch.insert
        #expect(applied == "이전텍스트" + objective, "\(current) → \(objective)")
      }
    }
  }
}
