import Foundation
import XCTest

@testable import HeekeyCore

// 초성
// ᄀ ᄁ ᄂ ᄃ ᄄ ᄅ ᄆ ᄇ ᄈ ᄉ ᄊ ᄋ ᄌ ᄍ ᄎ ᄏ ᄐ ᄑ ᄒ.
// 중성
// ᅡ ᅢ ᅣ ᅤ ᅥ ᅦ ᅧ ᅨ ᅩ ᅪ ᅫ ᅬ ᅭ ᅮ ᅯ ᅰ ᅱ ᅲ ᅳ ᅴ ᅵ.
// 종성
// ᆨ ᆩ ᆪ ᆫ ᆬ ᆭ ᆮ ᆯ ᆰ ᆱ ᆲ ᆳ ᆴ ᆵ ᆶ ᆷ ᆸ ᆹ ᆺ ᆻ ᆼ ᆽ ᆾ ᆿ ᇀ ᇁ ᇂ

final class ParserTests: XCTestCase {
  func testTokensToString() throws {
    XCTAssertEqual(
      str_to_tokens("ㅁㅁㅁ").string,
      "ㅁㅁㅁ"
    )
  }

  func testParse() throws {
    let testCases: [(String, [Symbol])] = [
      (
        "ㄱㅏㄲㄱ",
        [
          .init(초성.ㄱ),
          .init(중성.ㅏ),
          .init(종성.ㄱㄱ),
          .init(초성.ㄱ),
        ]
      ),
      (
        "ㄱㅏㄸㄱ",
        [
          .init(초성.ㄱ),
          .init(중성.ㅏ),
          .init(초성.ㄷㄷ),
          .init(초성.ㄱ),
        ]
      ),
      (
        "ㄱㅏㄴㅏ",
        [
          .init(초성.ㄱ),
          .init(중성.ㅏ),
          .init(초성.ㄴ),
          .init(중성.ㅏ),
        ]
      ),
      (
        "ㄱㅏㄱㄱ",
        [
          .init(초성.ㄱ),
          .init(중성.ㅏ),
          .init(종성.ㄱ),
          .init(초성.ㄱ),
        ]
      ),  // ㄱㄱ + ? => 겹받칩 불가
      (
        "ㄱㅏㄱㅅ",
        [
          .init(초성.ㄱ),
          .init(중성.ㅏ),
          .init(종성.ㄱㅅ),
        ]
      ),
      (
        "ㄱㅏㄱㅅㄱ",
        [
          .init(초성.ㄱ),
          .init(중성.ㅏ),
          .init(종성.ㄱㅅ),
          .init(초성.ㄱ),
        ]
      ),  // ㄱㅅ + 자음 => 겹받침 완성
      (
        "ㄱㅏㄱㅅㅏ",
        [
          .init(초성.ㄱ),
          .init(중성.ㅏ),
          .init(종성.ㄱ),
          .init(초성.ㅅ),
          .init(중성.ㅏ),
        ]
      ),  // ㄱㅅ + 모음 => 겹받침 안함
    ]

    for (str, expected) in testCases {
      XCTContext.runActivity(named: "Test parsing \(str)") { activity in
        XCTAssertEqual(
          str_to_tokens(str).parse(),
          expected
        )
      }
    }
  }

}
