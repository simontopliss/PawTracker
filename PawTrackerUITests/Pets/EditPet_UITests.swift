import XCTest

final class EditPet_UITests: XCTestCase {

    // swiftlint:disable:next implicitly_unwrapped_optional
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func test_EditPet() throws {
        app.tabBars["Tab Bar"].buttons["Pets"].tap()

        let petListViewCollectionView = app.collectionViews["PetListView_List"]
        XCTAssertTrue(petListViewCollectionView.exists)

        let firstCell = petListViewCollectionView.cells.firstMatch
        firstCell.tap() // Go to PetDetailView

        let navBar = app.navigationBars.firstMatch
        XCTAssert(navBar.exists)

        let editButton = navBar.buttons["PetDetail_EditButton"]
        XCTAssertTrue(editButton.exists)
        editButton.tap()

        let collectionViewsQuery = app.collectionViews

        let petNameTextField = collectionViewsQuery.textFields["EditPetView_Name"]
        XCTAssertTrue(petNameTextField.exists)

        let petTypeTextField = collectionViewsQuery.textFields["EditPetView_Type"]
        XCTAssertTrue(petTypeTextField.exists)

        let petBreedTextField = collectionViewsQuery.textFields["EditPetView_Breed"]
        XCTAssertTrue(petBreedTextField.exists)

        let petWeightTextField = collectionViewsQuery.textFields["EditPetView_Weight"]
        XCTAssertTrue(petWeightTextField.exists)

        let petDateOfBirthPicker = collectionViewsQuery.datePickers["EditPetView_DateOfBirth"]
        XCTAssertTrue(petDateOfBirthPicker.exists)

        let petDescriptionTextView = collectionViewsQuery.textViews["EditPetView_Description"]
        XCTAssertTrue(petDescriptionTextView.exists)
    }

}
