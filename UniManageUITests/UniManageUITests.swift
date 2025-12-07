import XCTest

final class UniManageUITests: XCTestCase {

    // Make the XCUIApplication available to all tests
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false

        // Launch the app before each test
        app.launch()
    }

    override func tearDownWithError() throws {
        // Optional cleanup
    }

    func testSearchFunctionality() throws {
        app.tabBars["Tab Bar"].buttons["Students"].tap()

        let loadButton = app.buttons["LoadButton"]
        if loadButton.exists {
            loadButton.tap()
        }

        XCTAssertTrue(
            app.collectionViews["StudentList"].waitForExistence(timeout: 5.0)
        )

        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.typeText("alice")

        let aliceCell = app.staticTexts["Alice Rodriguez"]

        XCTAssertTrue(
            aliceCell.exists,
            "Search should find Alice even with lowercase input."
        )
    }
}
