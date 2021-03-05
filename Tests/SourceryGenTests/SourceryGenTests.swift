import XCTest
@testable import SourceryGen

final class SourceryGenTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SourceryGen().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
