@testable import PawTracker
import XCTest

final class ContactsViewModelTests: XCTestCase {

    // swiftlint:disable:next implicitly_unwrapped_optional
    private var contactsViewModel: ContactsViewModel!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var contacts: [Contact]!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var contact: Contact!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var validator: ContactValidator!

    override func setUpWithError() throws {
        try super.setUpWithError()
        contactsViewModel = ContactsViewModel()
        contacts = Contact.mockContacts
        contact = Contact.mockContact
        validator = ContactValidator()
    }

    override func tearDownWithError() throws {
        contactsViewModel.deleteUserContacts()
        contactsViewModel = nil
        contacts = nil
        contact = nil
        validator = nil
        try super.tearDownWithError()
    }

    func test_ContactsViewModel_loadsContacts() {
        XCTAssertNoThrow(contactsViewModel.loadContacts())
        XCTAssertFalse(contactsViewModel.contacts.isEmpty)
        XCTAssertEqual(contact.id, UUID(uuidString: "FEDB5573-CDF7-42B3-B0ED-387718AE7561"))
    }

    func test_ContactsViewModel_savesContacts() {
        XCTAssertNoThrow(contactsViewModel.saveContacts())
    }

    func test_AddContact_increasesContactCount() {
        let contactCountBefore = contactsViewModel.contacts.count
        let newContact = createContact()
        contactsViewModel.addContact(newContact)
        let contactCountAfter = contactsViewModel.contacts.count
        XCTAssertEqual(contactCountBefore + 1, contactCountAfter)
    }

    func test_DeleteContact_decreasesContactCount() {
        let eventCountBefore = contactsViewModel.contacts.count
        // swiftlint:disable:next force_unwrapping
        contactsViewModel.deleteContact(contactsViewModel.contacts.last!.id)
        let eventCountAfter = contactsViewModel.contacts.count
        XCTAssertEqual(eventCountBefore - 1, eventCountAfter)
    }

    func test_FindContact_findsContact() {
        let foundContact = contactsViewModel.findContactByID(
            // swiftlint:disable:next force_unwrapping
            UUID(uuidString: "FEDB5573-CDF7-42B3-B0ED-387718AE7561")!
        )
        XCTAssertNotNil(foundContact)
    }

    func test_UpdateContact_isSuccessful() {
        contact.name = "Testing"
        contactsViewModel.updateContact(contact)
        XCTAssertEqual(contact.name, "Testing")
    }

    func test_ValidateContact_isSuccessful() {
        XCTAssertNoThrow(contactsViewModel.validateContact(contact))
    }

    func test_ValidateContact_failsWithInvalidContact() {
        let contact = Contact(
            id: UUID(),
            name: "",
            address: "",
            postCode: "",
            phoneNumber: ""
        )
        contactsViewModel.validateContact(contact)
        XCTAssertTrue(contactsViewModel.hasValidatorError)
    }

    func createContact() -> Contact {
        Contact(
            id: UUID(),
            name: "Test Contact",
            address: "300 St Georges Road, Hull",
            postCode: "HU3 3TP",
            phoneNumber: "(01482) 304024"
        )
    }
}
