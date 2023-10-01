//
//  DailyFeedsList_UITests.swift
//  PawTrackerUITests
//
//  Created by Simon Topliss on 01/10/2023.
//

import XCTest

final class DailyFeedsList_UITests: XCTestCase {

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

    func test_DailyFeedsListView() throws {
        app.tabBars["Tab Bar"].buttons["Feeds"].tap()

        let dailyFeedsListViewCollectionView = app.collectionViews["DailyFeedsListView_List"]
        XCTAssert(dailyFeedsListViewCollectionView.exists)

        let firstCell = dailyFeedsListViewCollectionView.cells.firstMatch
        firstCell.tap() // Go to EditDailyFeedView

        let collectionViewsQuery = app.collectionViews

        let petNameTextField = collectionViewsQuery.staticTexts["LargeTitleView"]
        XCTAssertEqual(petNameTextField.label, "Fluffy")

        let petImage = collectionViewsQuery.images["PetDetailImageView"]
        XCTAssert(petImage.exists)

        let morningToggle = collectionViewsQuery.staticTexts["EditPetView_MorningToggle"]
        XCTAssert(morningToggle.exists)
        XCTAssertEqual(morningToggle.label, "Morning")

        let lunchToggle = collectionViewsQuery.staticTexts["EditPetView_LunchToggle"]
        XCTAssert(lunchToggle.exists)
        XCTAssertEqual(lunchToggle.label, "Lunch")

        let eveningToggle = collectionViewsQuery.staticTexts["EditPetView_EveningToggle"]
        XCTAssert(eveningToggle.exists)
        XCTAssertEqual(eveningToggle.label, "Evening")

        let submitButton = collectionViewsQuery.buttons["EditPetView_SubmitButton"]
        XCTAssert(submitButton.exists)
        XCTAssertEqual(submitButton.label, "Submit")

        submitButton.tap()
    }
}
