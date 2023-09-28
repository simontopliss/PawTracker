//
//  PetListView_UITests.swift
//  UITests
//
//  Created by Simon Topliss on 25/03/2023.
//

import XCTest

final class PetListView_UITests: XCTestCase {

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

    func test_PetListView() {
        app.tabBars["Tab Bar"].buttons["Pets"].tap()

        let navBar = app.navigationBars["My Pets"]
        XCTAssertTrue(navBar.exists)

        let petListViewNavigationTitle = navBar.staticTexts["My Pets"]
        XCTAssertTrue(petListViewNavigationTitle.exists)
        XCTAssertEqual(petListViewNavigationTitle.label, "My Pets")

        let petListViewCollectionView = app.collectionViews["PetListView_List"]
        XCTAssertTrue(petListViewCollectionView.exists)

        let firstCell = petListViewCollectionView.cells.firstMatch
        firstCell.tap() // Go to PetDetailView

        let petListViewNavBar = app.navigationBars.firstMatch
        XCTAssert(petListViewNavBar.exists)

        let petNameStaticText = app.staticTexts["PetDetailView_PetName"]
        XCTAssert(petNameStaticText.exists)
        XCTAssertFalse(petNameStaticText.label.isEmpty)

        let petTypeKeyStaticText = app.staticTexts["PetDetailRowView_Type:"]
        XCTAssert(petTypeKeyStaticText.exists)
        XCTAssertFalse(petNameStaticText.label.isEmpty)

        let petTypeValueStaticText = app.staticTexts["PetDetailRowView_Type:_Cat"]
        XCTAssert(petTypeValueStaticText.exists)
        XCTAssertFalse(petTypeValueStaticText.label.isEmpty)

        let petBreedKeyStaticText = app.staticTexts["PetDetailRowView_Breed:"]
        XCTAssert(petBreedKeyStaticText.exists)
        XCTAssertFalse(petBreedKeyStaticText.label.isEmpty)

        let petBreedValueStaticText = app.staticTexts["PetDetailRowView_Breed:_Persian Long-haired"]
        XCTAssert(petBreedValueStaticText.exists)
        XCTAssertFalse(petBreedValueStaticText.label.isEmpty)

        let petGenderKeyStaticText = app.staticTexts["PetDetailRowView_Gender:"]
        XCTAssert(petGenderKeyStaticText.exists)
        XCTAssertFalse(petGenderKeyStaticText.label.isEmpty)

        let petGenderValueStaticText = app.staticTexts["PetDetailRowView_Gender:_Female"]
        XCTAssert(petGenderValueStaticText.exists)
        XCTAssertFalse(petGenderValueStaticText.label.isEmpty)

        let petWeightKeyStaticText = app.staticTexts["PetDetailRowView_Weight:"]
        XCTAssert(petWeightKeyStaticText.exists)
        XCTAssertFalse(petWeightKeyStaticText.label.isEmpty)

        let petWeightValueStaticText = app.staticTexts["PetDetailRowView_Weight:_4.2 kg"]
        XCTAssert(petWeightValueStaticText.exists)
        XCTAssertFalse(petWeightValueStaticText.label.isEmpty)

        let petDateOfBirthKeyStaticText = app.staticTexts["PetDetailRowView_Date of Birth:"]
        XCTAssert(petDateOfBirthKeyStaticText.exists)
        XCTAssertFalse(petDateOfBirthKeyStaticText.label.isEmpty)

        let petDescriptionTitleStaticText = app.staticTexts["PetDetailRowView_DescriptionTitle"]
        XCTAssert(petDescriptionTitleStaticText.exists)
        XCTAssertFalse(petDescriptionTitleStaticText.label.isEmpty)

        let petDescriptionStaticText = app.staticTexts["PetDetailRowView_Description"]
        XCTAssert(petDescriptionStaticText.exists)
        XCTAssertFalse(petDescriptionStaticText.label.isEmpty)

        app.navigationBars.firstMatch.buttons["My Pets"].tap() // Go back to PetListView

//        let petCount1 = petListViewCollectionView.cells.count
//        petListViewCollectionView.cells.firstMatch.swipeLeft()
//        let petOneButton = petListViewCollectionView.buttons["PetListView_SwipeDeleteButton"].firstMatch
//        petOneButton.tap() // Delete pet from list
//        let petCount2 = petListViewCollectionView.cells.count
//        XCTAssertTrue(petCount1 - petCount2 == 1)

    }

}
