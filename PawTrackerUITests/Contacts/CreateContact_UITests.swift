//
//  CreateContact_UITests.swift
//  PawTrackerUITests
//
//  Created by Simon Topliss on 01/10/2023.
//

import XCTest

final class CreateContact_UITests: XCTestCase {

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

    func test_CreateContact() {

        app.tabBars["Tab Bar"].buttons["Contacts"].tap()

        let addButton = app.navigationBars["Contacts"].buttons["ContactsListView_AddButton"]
        XCTAssert(addButton.exists)

        // Go to CreateContactView
        addButton.tap()

        let collectionViewsQuery = app.collectionViews

        let nameTextField = collectionViewsQuery.textFields["CreateContactView_NameTextField"]
        XCTAssertEqual(nameTextField.placeholderValue, "Name")

        nameTextField.tap()
        nameTextField.typeText("Test Name")
        // swiftlint:disable:next force_cast
        XCTAssertEqual(nameTextField.value as! String, "Test Name")

        let addressTextField = collectionViewsQuery.textViews["CreateContactView_AddressTextField"]
        XCTAssertEqual(addressTextField.placeholderValue, "Address")

        addressTextField.tap()
        addressTextField.typeText("123 Test Street")
        // swiftlint:disable:next force_cast
        XCTAssertEqual(addressTextField.value as! String, "123 Test Street")

        let postCodeTextField = collectionViewsQuery.textFields["CreateContactView_PostCodeTextField"]
        XCTAssertEqual(postCodeTextField.placeholderValue, "Post Code")

        postCodeTextField.tap()
        postCodeTextField.typeText("TE5T 1NG")
        // swiftlint:disable:next force_cast
        XCTAssertEqual(postCodeTextField.value as! String, "TE5T 1NG")

        let telephoneTextField = collectionViewsQuery.textFields["CreateContactView_TelephoneTextField"]
        XCTAssertEqual(telephoneTextField.placeholderValue, "Telephone")

        telephoneTextField.tap()
        telephoneTextField.typeText("01234567890")
        // swiftlint:disable:next force_cast
        XCTAssertEqual(telephoneTextField.value as! String, "01234567890")

        collectionViewsQuery.buttons["CreateContactView_SubmitButton"].tap()
    }

    func test_CancelButton() {}
}
