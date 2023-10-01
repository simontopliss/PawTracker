//
//  CreateDailyFeeds_UITests.swift
//  PawTrackerUITests
//
//  Created by Simon Topliss on 01/10/2023.
//

import XCTest

final class CreateDailyFeeds_UITests: XCTestCase {

    // swiftlint:disable:next implicitly_unwrapped_optional
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = true

        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func test_CreateDailyFeed() throws {
        app.tabBars["Tab Bar"].buttons["Feeds"].tap()

        let dailyFeedsListViewCollectionView = app.collectionViews["DailyFeedsListView_List"]
        XCTAssert(dailyFeedsListViewCollectionView.exists)

        let addButton = app.buttons["DailyFeedsListView_AddButton"]
        XCTAssert(addButton.exists)
        addButton.tap()

        let collectionViewsQuery = app.collectionViews

        let morningToggle = collectionViewsQuery.staticTexts["CreateDailyFeedView_MorningToggle"]
        XCTAssert(morningToggle.exists)
        XCTAssertEqual(morningToggle.label, "Morning")

        let lunchToggle = collectionViewsQuery.staticTexts["CreateDailyFeedView_LunchToggle"]
        XCTAssert(lunchToggle.exists)
        XCTAssertEqual(lunchToggle.label, "Lunch")

        let eveningToggle = collectionViewsQuery.staticTexts["CreateDailyFeedView_EveningToggle"]
        XCTAssert(eveningToggle.exists)
        XCTAssertEqual(eveningToggle.label, "Evening")

        let submitButton = collectionViewsQuery.buttons["CreateDailyFeedView_SubmitButton"]
        XCTAssert(submitButton.exists)
        XCTAssertEqual(submitButton.label, "Submit")
    }
}
