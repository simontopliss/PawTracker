//
//  EventsView_UITests.swift
//  UITests
//
//  Created by Simon Topliss on 24/03/2023.
//

import XCTest

final class EventsView_UITests: XCTestCase {

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

    func test_EventsView() {
        app.tabBars["Tab Bar"].buttons["Events"].tap()

        let eventsListViewCollectionView = app.collectionViews["EventsListView_List"]
        XCTAssert(eventsListViewCollectionView.exists)

        let firstCell = eventsListViewCollectionView.cells.firstMatch
        firstCell.tap() // Go to EventDetailView

        // let petPicker = app.pickerWheels["EditEventView_PetPicker"]
        // XCTAssert(petPicker.exists)

        let datePicker = app.datePickers["EditEventView_DatePicker"]
        XCTAssert(datePicker.exists)

        let subjectTextField = app.textFields["EditEventView_SubjectTextField"]
        XCTAssertEqual(subjectTextField.placeholderValue, "Subject")

        // let notesTextField = app.textFields["EditEventView_NotesTextField"]
        // XCTAssert(notesTextField.exists)

        let saveButton = app.buttons["EditPetView_SubmitButton"]
        XCTAssert(saveButton.exists)

        let deleteButton = app.buttons["EditEventView_DeleteButton"]
        XCTAssert(deleteButton.exists)

        app.navigationBars.firstMatch.buttons["Events"].tap()
    }
}
