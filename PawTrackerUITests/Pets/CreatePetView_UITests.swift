import XCTest

final class CreatePetView_UITests: XCTestCase {

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

    func test_CreatePet() {
        app.tabBars["Tab Bar"].buttons["Pets"].tap()

        let navBar = app.navigationBars["My Pets"]

        let petListViewAddPetButton = navBar.buttons["PetListView_AddPetButton"]
        XCTAssertTrue(petListViewAddPetButton.exists)

        petListViewAddPetButton.tap() // Show the Add Pet sheet

        let collectionViewsQuery = app.collectionViews

        let petNameTextField = collectionViewsQuery.textFields["CreatePetView_Name"]
        XCTAssertTrue(petNameTextField.exists)
        petNameTextField.tap()
        petNameTextField.typeText("Test Pet")
        // swiftlint:disable:next force_cast
        XCTAssertEqual(petNameTextField.value as! String, "Test Pet")

        let petTypeTextField = collectionViewsQuery.textFields["CreatePetView_Type"]
        XCTAssertTrue(petTypeTextField.exists)
        petTypeTextField.tap()
        petTypeTextField.typeText("Test Type")
        // swiftlint:disable:next force_cast
        XCTAssertEqual(petTypeTextField.value as! String, "Test Type")

        let petBreedTextField = collectionViewsQuery.textFields["CreatePetView_Breed"]
        XCTAssertTrue(petBreedTextField.exists)
        petBreedTextField.tap()
        petBreedTextField.typeText("Test Breed")
        // swiftlint:disable:next force_cast
        XCTAssertEqual(petBreedTextField.value as! String, "Test Breed")

        let petWeightTextField = collectionViewsQuery.textFields["CreatePetView_Weight"]
        XCTAssertTrue(petWeightTextField.exists)
        petWeightTextField.tap()
        petWeightTextField.typeText(".50")
        // swiftlint:disable:next force_cast
        XCTAssertEqual(petWeightTextField.value as! String, "0.50")

//        app.scrollViews.element.swipeDown()
//
//        let petDescriptionTextField = collectionViewsQuery.textFields["CreatePetView_Description"]
//        XCTAssertTrue(petDescriptionTextField.exists)
//        petDescriptionTextField.tap()
//        petDescriptionTextField.typeText("Test Description")
//        XCTAssertEqual(petDescriptionTextField.value as! String, "Test Description")
//
//        collectionViewsQuery.buttons["CreatePetView_SubmitButton"].tap()
    }
}
