//
//  UniManageTests.swift
//  UniManageTests
//
//  Created by Gabriela Sanchez on 06/12/25.
//

import XCTest

final class UniManageUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    // SCENARIO 1: FLAKY ASYNC TEST
    func testStudentListLoads() throws {
        app.tabBars["Tab Bar"].buttons["Students"].tap()
        
        app.buttons["LoadButton"].tap()

        let aliceCell = app.staticTexts["Alice Rodriguez"]
        XCTAssertTrue(aliceCell.exists, "Student cell did not appear!")
    }

    // SCENARIO 2: TIMEZONE LOGIC FAILURE
    func testExamDateDisplay() throws {
        app.tabBars["Tab Bar"].buttons["Courses"].tap()
        
        let now = Date()
        let localFormatter = DateFormatter()
        localFormatter.dateStyle = .medium
        localFormatter.timeStyle = .short
        
        let expectedString = "Exam: \(localFormatter.string(from: now))"
        
        let examLabel = app.staticTexts["ExamDate_CS401"]
        XCTAssertEqual(examLabel.label, expectedString)
    }

    // SCENARIO 3: UN-HITTABLE ELEMENT
    func testResetButton() throws {
        app.tabBars["Tab Bar"].buttons["Settings"].tap()
        
        app.buttons["ResetButton"].tap()
        
        let alert = app.alerts["Reset Data?"]
        XCTAssertTrue(alert.exists)
    }
    
    func testSignOutButtonWorks() throws {
        app.tabBars["Tab Bar"].buttons["Settings"].tap()
        
        app.collectionViews.element.swipeUp()

        app.buttons["SignOutButton"].tap()
        
        let alert = app.alerts["Sign Out?"]
        XCTAssertTrue(alert.exists)
    }
}
