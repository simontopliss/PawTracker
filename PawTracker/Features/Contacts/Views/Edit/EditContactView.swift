//
//  EditContactView.swift
//  PawTracker
//
//  Created by Simon Topliss on 05/05/2023.
//

import SwiftUI

struct EditContactView: View {

    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @Binding var contact: Contact

    // MARK: - BODY
    var body: some View {
        Form {
            Group {
                Section {
                    TextField("Name", text: $contact.name)
                        .fontWeight(.semibold)
                        .accessibilityIdentifier("EditContactView_NameTextField")

                    TextField("Address", text: $contact.address, axis: .vertical)
                        .lineLimit(3...10)
                        .accessibilityIdentifier("EditContactView_AddressTextField")

                    TextField("Post Code", text: $contact.postCode)
                        .accessibilityIdentifier("EditContactView_PostCodeTextField")

                    TextField("Telephone", text: $contact.phoneNumber)
                        .accessibilityIdentifier("EditContactView_TelephoneTextField")
                }
                .foregroundColor(Constants.AppColors.textColor)

                Section {
                    Button("Submit") {
                        contactsViewModel.validateContact(contact)
                        if contactsViewModel.hasValidatorError == false {
                            contactsViewModel.updateContact(contact)
                            dismiss()
                        }
                    }
                    .accessibilityIdentifier("EditContactView_SubmitButton")
                }
            }
            .fontDesign(.rounded)
        }
        .alert(
            isPresented: $contactsViewModel.hasValidatorError,
            error: contactsViewModel.validatorError
        ) {
            Button("Cancel", role: .cancel) {}
                .accessibilityIdentifier("EditContactView_ValidatorErrorAlert_CancelButton")
        }
        .navigationTitle("Edit Contact")
    }
}

// MARK: - PREVIEW
struct EditContactView_Previews: PreviewProvider {
    static let contact = Contact.mockContact

    static var previews: some View {
        EditContactView(contact: .constant(contact))
            .environmentObject(ContactsViewModel())
    }
}
