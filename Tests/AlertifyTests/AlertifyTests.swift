import XCTest
@testable import Alertify

final class AlertifyTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Alertify().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
