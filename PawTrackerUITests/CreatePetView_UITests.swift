//
//  CreatePetView_UITests.swift
//  UITests
//
//  Created by Simon Topliss on 03/04/2023.
//

import XCTest

final class CreatePetView_UITests: XCTestCase {

    // swiftlint:disable:next implicitly_unwrapped_optional
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func test_CreatePet() {
        app.tabBars["Tab Bar"].buttons["Pets"].tap()

        let navBar = app.navigationBars["My Pets"]

        let petListViewAddPetButton = navBar.buttons["PetListView_AddPetButton"]
        XCTAssertTrue(petListViewAddPetButton.exists)

        petListViewAddPetButton.tap() // Show the Edit sheet

    }
}
