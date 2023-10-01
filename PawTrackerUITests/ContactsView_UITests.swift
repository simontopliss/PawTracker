//
//  ContactsView_UITests.swift
//  UITests
//
//  Created by Simon Topliss on 24/03/2023.
//

import XCTest

final class ContactsView_UITests: XCTestCase {

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

    func test_ContactsListView() {
        app.tabBars["Tab Bar"].buttons["Contacts"].tap()

        let contactsListViewCollectionView = app.collectionViews["ContactsListView_List"]
        XCTAssert(contactsListViewCollectionView.exists)

        let firstCell = contactsListViewCollectionView.cells.firstMatch
        firstCell.tap() // Go to ContactDetailView

        let nameTextField = app.collectionViews.textFields["EditContactView_NameTextField"]
        XCTAssertEqual(nameTextField.placeholderValue, "Name")
        // swiftlint:disable:next force_cast
        XCTAssertEqual(nameTextField.value as! String, "Peel Vets")

        let postCodeTextField = app.collectionViews.textFields["EditContactView_PostCodeTextField"]
        XCTAssertEqual(postCodeTextField.placeholderValue, "Post Code")
        // swiftlint:disable:next force_cast
        XCTAssertEqual(postCodeTextField.value as! String, "HU8 7SH")

        let telephoneTextField = app.collectionViews.textFields["EditContactView_TelephoneTextField"]
        XCTAssertEqual(telephoneTextField.placeholderValue, "Telephone")
        // swiftlint:disable:next force_cast
        XCTAssertEqual(telephoneTextField.value as! String, "(01482) 174370")
    }

    func test_CreateContact() {

        app.tabBars["Tab Bar"].buttons["Contacts"].tap()

        let addButton = app.navigationBars["Contacts"].buttons["ContactsListView_AddButton"]
        XCTAssert(addButton.exists)

        // Go to CreateContactView
        addButton.tap()

        let collectionViewsQuery = app.collectionViews
        let nameTextField = collectionViewsQuery.textFields["Name"]
        XCTAssertEqual(nameTextField.placeholderValue, "Name")
        nameTextField.tap()

        collectionViewsQuery.textViews["Address"].tap()

        let postCodeTextField = collectionViewsQuery.textFields["Post Code"]
        postCodeTextField.tap()

        let telephoneTextField = collectionViewsQuery.textFields["Telephone"]
        telephoneTextField.tap()
        nameTextField.tap()
        collectionViewsQuery.buttons["CreateContactView_SubmitButton"].tap()
    }

}
