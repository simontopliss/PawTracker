//
//  CreateContactView.swift
//  PawTracker
//
//  Created by Simon Topliss on 05/05/2023.
//

import SwiftUI

struct CreateContactView: View {

    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var contactsViewModel: ContactsViewModel

    @State private var contact = Contact(
        id: UUID(),
        name: "",
        address: "",
        postCode: "",
        phoneNumber: ""
    )

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            Form {
                Group {
                    Section {
                        TextField("Name", text: $contact.name)
                            .fontWeight(.semibold)
                        TextField("Address", text: $contact.address, axis: .vertical)
                            .lineLimit(3...10)
                        TextField("Post Code", text: $contact.postCode)
                        TextField("Telephone", text: $contact.phoneNumber)
                    }
                    .foregroundColor(Constants.AppColors.textColor)

                    Section {
                        Button("Submit") {
                            contactsViewModel.validateContact(contact)
                            if contactsViewModel.hasValidatorError == false {
                                contactsViewModel.addContact(contact)
                                dismiss()
                            }
                        }
                        .accessibilityIdentifier("CreateContactView_SubmitButton")
                    }
                }
                .fontDesign(.rounded)
            }
            .alert(
                isPresented: $contactsViewModel.hasValidatorError,
                error: contactsViewModel.validatorError
            ) {
                Button("Cancel", role: .cancel) {}
            }
            .navigationTitle("Add Contact")
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .fontDesign(.rounded)
                    .accessibilityIdentifier("CreateContactView_CancelButton")
                }
            }
        }
    }
}

// MARK: - PREVIEW
struct CreateContactView_Previews: PreviewProvider {
    static var previews: some View {
        CreateContactView()
            .environmentObject(ContactsViewModel())
    }
}
