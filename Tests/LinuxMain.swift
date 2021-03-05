import XCTest

import SourceryGenTests

var tests = [XCTestCaseEntry]()
tests += SourceryGenTests.allTests()
XCTMain(tests)
