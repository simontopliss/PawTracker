import XCTest

class ContentView_UITests: XCTestCase {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        // In UI tests it’s important to set the initial state - such as interface orientation
        // - required for your tests before they run. The setUp method is a good place to do this.
        continueAfterFailure = true

        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_TabNavigation() {
        // Assert that HomeViewTab is selected initially
        XCTAssertTrue(app.buttons["HomeViewTab"].isSelected)

        // Navigate to PetListViewTab
        app.buttons["PetListViewTab"].tap()
        XCTAssertTrue(app.buttons["PetListViewTab"].isSelected)

        // Navigate to EventsListViewTab
        app.buttons["EventsListViewTab"].tap()
        XCTAssertTrue(app.buttons["EventsListViewTab"].isSelected)

        // Navigate to DailyFeedsListViewTab
        app.buttons["DailyFeedsListViewTab"].tap()
        XCTAssertTrue(app.buttons["DailyFeedsListViewTab"].isSelected)

        // Navigate to ContactsListViewTab
        app.buttons["ContactsListViewTab"].tap()
        XCTAssertTrue(app.buttons["ContactsListViewTab"].isSelected)
    }
}
