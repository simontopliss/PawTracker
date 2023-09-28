//
//  ContactsViewModel.swift
//  PawTracker
//
//  Created by Simon Topliss on 05/05/2023.
//

import Foundation

final class ContactsViewModel: ObservableObject {

    @Published var contacts: Contacts = []

    private let validator = ContactValidator()
    @Published var validatorError: ContactValidator.CreateContactValidatorError?
    @Published var hasValidatorError = false

    init() {
        contacts = loadContacts()
    }

    func validateContact(_ contact: Contact) {
        do {
            try validator.validate(contact)
        } catch {
            hasValidatorError = true
            validatorError = error as? ContactValidator.CreateContactValidatorError
            print(error.localizedDescription)
        }
    }

    func loadContacts() -> Contacts {
        do {
            let userContactsJSON = FileManager.documentsDirectory
                .appendingPathComponent("contacts")
                .appendingPathExtension("json")
                .path

            let contactsJSONPath = FileManager.default.fileExists(atPath: userContactsJSON)
                ? userContactsJSON
                : Bundle.main.path(forResource: "contacts", ofType: "json")

            guard let contactsJSONPath,
                  let data = FileManager.default.contents(atPath: contactsJSONPath)
            // swiftlint:disable:previous indentation_width
            else {
                print("Unable to read JSON file.")
                return []
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            return try decoder.decode(Contacts.self, from: data)

        } catch {
            print("loadContacts() error:" + String(describing: error))
            return []
        }
    }

    func saveContacts() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            encoder.keyEncodingStrategy = .convertToSnakeCase
            encoder.outputFormatting = .prettyPrinted

            let data = try? encoder.encode(contacts)

            let savePath = FileManager.documentsDirectory
                .appendingPathComponent("contacts")
                .appendingPathExtension("json")

            try data?.write(to: savePath, options: [.atomic, .completeFileProtection])

        } catch {
            print("saveContacts() error:\n\(error.localizedDescription)")
        }
    }

    func deleteUserContacts() {
        do {
            let jsonURL = FileManager.documentsDirectory
                .appendingPathComponent("contacts")
                .appendingPathExtension("json")
            if FileManager.default.fileExists(atPath: jsonURL.path) {
                try FileManager.default.removeItem(atPath: jsonURL.path)
            }
        } catch {
            print("deleteUserContacts() error:\n" + String(describing: error))
        }
    }

    func addContact(_ newContact: Contact) {
        contacts.append(newContact)
        saveContacts()
    }

    func updateContact(_ contact: Contact) {
        guard let index = contacts.firstIndex(where: { $0.id == contact.id }) else {
            addContact(contact)
            return
        }
        contacts[index] = contact
        saveContacts()
    }

    func deleteContact(_ contactID: UUID) {
        contacts.removeAll { $0.id == contactID }
        saveContacts()
    }

    func findContactByID(_ contactID: UUID) -> Contact? {
        contacts.first { $0.id == contactID }
    }
}
