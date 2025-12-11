
import XCTest

final class UniManageUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - UI TEST 1: Load students safely with waits

    func testLoadingStudentsShowsAliceInRoster() throws {

        // 1. Wait for tab bar to exist
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 10), "Tab bar did not appear.")

        // 2. Tap Students tab
        let studentsTab = tabBar.buttons["Students"]
        XCTAssertTrue(studentsTab.waitForExistence(timeout: 10), "Students tab missing.")
        studentsTab.tap()

        // 3. Wait for Load Database button
        let loadButton = app.buttons["LoadButton"]
        XCTAssertTrue(loadButton.waitForExistence(timeout: 10), "LoadButton not found.")
        loadButton.tap()

        // 4. Wait for the table to load
        let studentList = app.tables["StudentList"]
        XCTAssertTrue(studentList.waitForExistence(timeout: 15), "Student list never appeared.")

        // 5. Wait for Alice to show
        let alice = studentList.staticTexts["Alice Rodriguez"]
        XCTAssertTrue(alice.waitForExistence(timeout: 15), "Alice Rodriguez not found in list.")
    }


    // MARK: - UI TEST 2: Tap GPA badge safely

    func testTappingGpaBadgeAfterLoading() throws {

        // 1. Load Students tab
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 10))

        let studentsTab = tabBar.buttons["Students"]
        XCTAssertTrue(studentsTab.waitForExistence(timeout: 10))
        studentsTab.tap()

        // 2. Tap LoadButton
        let loadButton = app.buttons["LoadButton"]
        XCTAssertTrue(loadButton.waitForExistence(timeout: 10))
        loadButton.tap()

        // 3. Wait for list
        let studentList = app.tables["StudentList"]
        XCTAssertTrue(studentList.waitForExistence(timeout: 15))

        // 4. Look for ANY GPA button (we don't know which one appears first)
        let gpaButton = studentList.buttons.matching(NSPredicate(format: "identifier BEGINSWITH %@", "GPA_")).firstMatch
        XCTAssertTrue(gpaButton.waitForExistence(timeout: 15), "No GPA badge found.")

        // 5. Tap the GPA badge (should not crash)
        gpaButton.tap()
    }
}
