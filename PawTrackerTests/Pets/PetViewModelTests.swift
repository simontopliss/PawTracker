@testable import PawTracker
import XCTest

final class PetViewModelTests: XCTestCase {

    // swiftlint:disable:next implicitly_unwrapped_optional
    private var petViewModel: PetViewModel!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var pet: Pet!

    override func setUpWithError() throws {
        try super.setUpWithError()
        petViewModel = PetViewModel()
        pet = petViewModel.pets.first
    }

    override func tearDownWithError() throws {
        petViewModel = nil
        try super.tearDownWithError()
    }

    func test_PetViewModel_loadsMockPets() {
        XCTAssertFalse(petViewModel.pets.isEmpty, "PetViewModel should load the mockPets")
        XCTAssertNotNil(pet.id, "pet.id should not be nil")
        XCTAssertEqual(pet.name, "Fluffy")
        XCTAssertEqual(pet.breed, "Persian Long-haired")
        XCTAssertEqual(pet.gender, Pet.Gender.female.rawValue)
        XCTAssertEqual(pet.weight, 4.2)
        // swiftlint:disable:next force_unwrapping
        XCTAssertEqual(pet.dateOfBirth!, isoDateAsDate("2022-03-20T00:00:00Z"))
        XCTAssertEqual(pet.description, "My cat smells of cat food.")
    }

    func test_PetViewModel_savesPets() {
        XCTAssertNoThrow(petViewModel.savePets())
    }

    func test_PetViweModel_findsPet() {
        // swiftlint:disable:next force_unwrapping
        let pet1 = petViewModel.findPetByID(UUID(uuidString: "08F40734-EFE6-4D75-B59A-37CD55948DBE")!)
        XCTAssertNotNil(pet1)
        let pet2 = petViewModel.findPetByName("Fluffy")
        XCTAssertNotNil(pet2)
    }

    func test_NewPet_isValid() {
        let pet = Pet(
            id: UUID(),
            modDate: Date(),
            name: "Brian",
            type: "Dog",
            breed: "Labrador",
            gender: Pet.Gender.male.rawValue,
            weight: 12.6,
            description: "The dog from Family Guy.",
            // swiftlint:disable:next force_unwrapping
            petImage: UIImage(named: Constants.General.blankPetImage)!
        )
        petViewModel.validatePet(pet)
        XCTAssertFalse(petViewModel.hasValidatorError)
    }

    func test_NewPet_isNotValid() {
        let pet = Pet(
            id: UUID(),
            modDate: Date(),
            name: "Brian",
            type: "",
            breed: "Labrador",
            gender: Pet.Gender.male.rawValue,
            weight: 12.6,
            description: "The dog from Family Guy.",
            // swiftlint:disable:next force_unwrapping
            petImage: UIImage(named: Constants.General.blankPetImage)!
        )
        petViewModel.validatePet(pet)
        XCTAssertTrue(petViewModel.hasValidatorError)
    }

    func test_PetId_isValid() {
        XCTAssertNotNil(pet.id, "pet.id should not be nil")
    }

    func test_PetName_isValid() {
        XCTAssertNotNil(pet.name, "pet.name should not be nil")
        XCTAssertNotEqual(pet.name, "", "pet.name should not be empty string")
    }

    func test_PetType_isValid() {
        XCTAssertNotNil(pet.type, "pet.type should not be nil")
        XCTAssertNotEqual(pet.type, "", "pet.type should not be empty string")
    }

    func test_PetGender_isValid() {
        XCTAssertNotNil(pet.gender, "pet.gender should not be nil")
    }

    func test_PetWeight_isValid() {
        pet.weight = 3.3
        XCTAssertNotNil(pet.weight, "pet.weight should not be nil")
        XCTAssertGreaterThanOrEqual(pet.weight, 0.0, "pet.weight should not be less than 0.0")
    }

    func test_PetDateOfBirth_isValid() {
        XCTAssertNotNil(pet.dateOfBirth, "pet.dateOfBirth should not be nil")
    }

    func test_PetDeceased_isValid() {
        XCTAssertNotNil(pet.deceased, "pet.deceased should not be nil")
    }

    func test_PetAge_isOneYearOld() {
        let cal = Calendar.current
        let oneYearAgo = cal.date(byAdding: .year, value: -1, to: Date())! // swiftlint:disable:this force_unwrapping
        XCTAssertEqual(formatAge(oneYearAgo), "1 year old")
    }

    func test_PetBirthday_isToday() {
        let cal = Calendar.current
        let oneYearAgo = cal.date(byAdding: .year, value: -1, to: Date())! // swiftlint:disable:this force_unwrapping
        XCTAssertTrue(isBirthdayToday(oneYearAgo))
    }

    func test_PetSearchAndFilter() {
        petViewModel.searchQuery = "Cat"
        XCTAssertEqual(petViewModel.filteredPets.count, 3)
        petViewModel.searchQuery = "Fluffy"
        XCTAssertEqual(petViewModel.filteredPets.count, 1)
    }

    func test_AddPet_IncreasesPetCount() {
        let petCountBefore = petViewModel.pets.count
        let pet = createNewPet()
        petViewModel.addPet(pet)
        let petCountAfter = petViewModel.pets.count
        XCTAssertEqual(petCountBefore + 1, petCountAfter)
    }

    func test_DeletePet_DecreasesPetCount() {
        let petCountBefore = petViewModel.pets.count
        petViewModel.deletePet(petViewModel.pets.last!.id) // swiftlint:disable:this force_unwrapping
        let petCountAfter = petViewModel.pets.count
        XCTAssertEqual(petCountBefore - 1, petCountAfter)
    }

    func test_UpdatePet_updatesPet() {
        pet.name = "Test"
        petViewModel.updatePet(pet)
        XCTAssert(pet.name == "Test")
    }

    func test_SavePetImage_saveIsSuccessful() {
        // swiftlint:disable:next force_unwrapping
        XCTAssertNoThrow(petViewModel.savePetImage(pet: &pet, image: UIImage(named: "Fluffy")!))
    }

    func test_FilterPets_WhenSearchQueryIsEmpty() {
        petViewModel.searchQuery = ""
        petViewModel.filterPets()
        // Here we assume that petViewModel.pets already contains some pets
        XCTAssertEqual(petViewModel.filteredPets, petViewModel.pets)
    }

    func test_FilterPets_WhenSearchQueryMatchesName() {
        petViewModel.searchQuery = "PetName"
        petViewModel.filterPets()
        // Check if the filteredPets array contains the pet with the name "PetName"
    }

    func test_FilterPets_WhenSearchQueryMatchesType() {
        petViewModel.searchQuery = "PetType"
        petViewModel.filterPets()
        // Check if the filteredPets array contains the pet with the type "PetType"
    }

    func test_FilterPets_WhenSearchQueryMatchesBreed() {
        petViewModel.searchQuery = "PetBreed"
        petViewModel.filterPets()
        // Check if the filteredPets array contains the pet with the breed "PetBreed"
    }

    func createNewPet() -> Pet {
        let newPet = Pet(
            id: UUID(),
            modDate: Date(),
            name: "Test Pet",
            type: "Dog",
            breed: "Poodle",
            gender: Pet.Gender.male.rawValue,
            weight: 8.9,
            dateOfBirth: Date(),
            // swiftlint:disable:next line_length
            description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            // swiftlint:disable:next force_unwrapping
            petImage: UIImage(named: Constants.General.blankPetImage)!
        )
        return newPet
    }

}
