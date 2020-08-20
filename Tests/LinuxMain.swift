import XCTest

import niotsTests

var tests = [XCTestCaseEntry]()
tests += niotsTests.allTests()
XCTMain(tests)
