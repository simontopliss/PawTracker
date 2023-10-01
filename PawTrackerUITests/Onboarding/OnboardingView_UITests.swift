//
//  OnboardingView_UITests.swift
//  UITests
//
//  Created by Simon Topliss on 24/03/2023.
//

import XCTest

final class OnboardingView_UITests: XCTestCase {

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

    func test_OnboardingView() {
        app.tabBars["Tab Bar"].buttons["Home"].tap()

        app.buttons["OnboardingButton"].tap()

        let appNameStaticText = app.staticTexts["OnboardingAppName"]
        XCTAssertTrue(appNameStaticText.exists)
        XCTAssertFalse(appNameStaticText.label.isEmpty)

        let appSubTitleStaticText = app.staticTexts["OnboardingAppSubTitle"]
        XCTAssertTrue(appSubTitleStaticText.exists)
        XCTAssertFalse(appSubTitleStaticText.label.isEmpty)

        let featureTitleStaticText = app.staticTexts["FeatureRow_Title"].firstMatch
        XCTAssertTrue(featureTitleStaticText.exists)
        XCTAssertFalse(featureTitleStaticText.label.isEmpty)

        let featureDescriptionStaticText = app.staticTexts["FeatureRow_Description"].firstMatch
        XCTAssertTrue(featureDescriptionStaticText.exists)
        XCTAssertFalse(featureDescriptionStaticText.label.isEmpty)

        app.buttons["OnboardingViewSheet"].tap()

    }
}
