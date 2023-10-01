//
//  CreateEvent_UITests.swift
//  PawTrackerUITests
//
//  Created by Simon Topliss on 01/10/2023.
//

import XCTest

final class CreateEvent_UITests: XCTestCase {

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

    func test_CreateEventView() {
        app.tabBars["Tab Bar"].buttons["Events"].tap()

        let eventsListViewCollectionView = app.collectionViews["EventsListView_List"]
        XCTAssert(eventsListViewCollectionView.exists)

        let addButton = app.buttons["EventsListView_AddButton"]
        XCTAssert(addButton.exists)
        addButton.tap() // Create new event

        let collectionViewsQuery = app.collectionViews

        let datePicker = collectionViewsQuery.datePickers["CreateEventView_DatePicker"]
        XCTAssert(datePicker.exists)

        let subjectTextField = collectionViewsQuery.textFields["CreateEventView_SubjectTextField"]
        XCTAssertEqual(subjectTextField.placeholderValue, "Subject")

        let notesTextView = collectionViewsQuery.textViews["CreateEventView_NotesTextField"]
        XCTAssert(notesTextView.exists)

        let submitButton = app.buttons["CreateEventView_SubmitButton"]
        XCTAssert(submitButton.exists)
    }
}
