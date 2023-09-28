//
//  ContactsModelTests.swift
//  ModelTests
//
//  Created by Simon Topliss on 05/05/2023.
//

@testable import PawTracker
import XCTest

final class ContactsModelTests: XCTestCase {

    // swiftlint:disable:next implicitly_unwrapped_optional
    private var contactsViewModel: ContactsViewModel!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var contacts: [Contact]!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var contact: Contact!

    override func setUpWithError() throws {
        try super.setUpWithError()
        contactsViewModel = ContactsViewModel()
        contacts = Contact.mockContacts
        contact = Contact.mockContact
    }

    override func tearDownWithError() throws {
        contactsViewModel.deleteUserContacts()
        contactsViewModel = nil
        contacts = nil
        contact = nil
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
        // swiftlint:disable:next force_unwrapping
        let foundContact = contactsViewModel.findContactByID(UUID(uuidString: "FEDB5573-CDF7-42B3-B0ED-387718AE7561")!)
        XCTAssertNotNil(foundContact)
    }

    func test_UpdateContact_isSuccessful() {
        contact.name = "Testing"
        contactsViewModel.updateContact(contact)
        XCTAssertEqual(contact.name, "Testing")
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
