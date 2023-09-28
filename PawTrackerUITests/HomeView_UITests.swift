//
//  HomeView_UITests.swift
//  UITests
//
//  Created by Simon Topliss on 24/03/2023.
//

import XCTest

final class HomeView_UITests: XCTestCase {

    // swiftlint:disable:next implicitly_unwrapped_optional
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func test_HomeView() {

        app.tabBars["Tab Bar"].buttons["Home"].tap()

        let pawTrackerHeaderStaticText = app.staticTexts["PawTrackerHeader"]
        XCTAssertTrue(pawTrackerHeaderStaticText.exists)
        XCTAssertEqual(pawTrackerHeaderStaticText.label, "PawTracker")

        let pawTrackerHeaderBackgroundImage = app.images["BackgroundImage"]
        XCTAssertTrue(pawTrackerHeaderBackgroundImage.exists)

        // MARK: - Upcoming Events
        let upcomingEventsTitleStaticText = app.staticTexts["UpcomingEventsTitle"]
        XCTAssertTrue(upcomingEventsTitleStaticText.exists)
        XCTAssertEqual(upcomingEventsTitleStaticText.label, "Upcoming Events")

        let eventDateTimeStaticText = app.staticTexts["EventDateTime"].firstMatch
        XCTAssertTrue(eventDateTimeStaticText.exists)

        let eventPetNameStaticText = app.staticTexts["EventPetName"].firstMatch
        XCTAssertTrue(eventPetNameStaticText.exists)

        let eventSubjectStaticText = app.staticTexts["EventSubject"].firstMatch
        XCTAssertTrue(eventSubjectStaticText.exists)

        // MARK: - Daily Feeds
        let dailyFeedsTitleStaticText = app.staticTexts["TodayFeedsView_Title"]
        XCTAssertTrue(dailyFeedsTitleStaticText.exists)
        XCTAssertEqual(dailyFeedsTitleStaticText.label, "Today’s Feeds")

        let dailyFeedsMorningColumnHeaderStaticText = app.staticTexts["TodayFeedsView_MorningColumnHeader"]
        XCTAssertTrue(dailyFeedsMorningColumnHeaderStaticText.exists)
        XCTAssertEqual(dailyFeedsMorningColumnHeaderStaticText.label, "Morning")

        let dailyFeedsLunchColumnHeaderStaticText = app.staticTexts["TodayFeedsView_LunchColumnHeader"]
        XCTAssertTrue(dailyFeedsLunchColumnHeaderStaticText.exists)
        XCTAssertEqual(dailyFeedsLunchColumnHeaderStaticText.label, "Lunch")

        let dailyFeedsEveningColumnHeaderStaticText = app.staticTexts["TodayFeedsView_EveningColumnHeader"]
        XCTAssertTrue(dailyFeedsEveningColumnHeaderStaticText.exists)
        XCTAssertEqual(dailyFeedsEveningColumnHeaderStaticText.label, "Evening")

        let dailyFeedsPetNameStaticText = app.staticTexts["TodayFeedsView_PetName"].firstMatch
        XCTAssertTrue(dailyFeedsPetNameStaticText.exists)
        XCTAssertFalse(dailyFeedsPetNameStaticText.label.isEmpty)
    }
}
