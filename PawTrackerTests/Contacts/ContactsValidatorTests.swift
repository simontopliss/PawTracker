@testable import PawTracker
import XCTest

final class ContactsValidatorTests: XCTestCase {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var contactValidator: ContactValidator!

    override func setUp() {
        super.setUp()
        contactValidator = ContactValidator()
    }

    override func tearDown() {
        contactValidator = nil
        super.tearDown()
    }

    func testContactNameValidation() {
        let contact = Contact(
            id: UUID(),
            name: "",
            address: "123 Street",
            postCode: "XX77 7XX",
            phoneNumber: "1234567890"
        )

        XCTAssertThrowsError(try contactValidator.validate(contact)) { error in
            XCTAssertEqual(error as? ContactValidator.CreateContactValidatorError, .invalidName)
            XCTAssertEqual(error.localizedDescription, "Contact name can't be empty")
        }
    }

    func testContactAddressValidation() {
        let contact = Contact(
            id: UUID(),
            name: "John Doe",
            address: "",
            postCode: "XX77 7XX",
            phoneNumber: "1234567890"
        )

        XCTAssertThrowsError(try contactValidator.validate(contact)) { error in
            XCTAssertEqual(error as? ContactValidator.CreateContactValidatorError, .invalidAddress)
            XCTAssertEqual(error.localizedDescription, "Contact type can't be empty")
        }
    }

    func testContactPhoneNumberValidation() {
        let contact = Contact(
            id: UUID(),
            name: "John Doe",
            address: "123 Street",
            postCode: "XX77 7XX",
            phoneNumber: ""
        )

        XCTAssertThrowsError(try contactValidator.validate(contact)) { error in
            XCTAssertEqual(error as? ContactValidator.CreateContactValidatorError, .invalidPhoneNumber)
            XCTAssertEqual(error.localizedDescription, "Telephone number can't be empty")
        }
    }
}
