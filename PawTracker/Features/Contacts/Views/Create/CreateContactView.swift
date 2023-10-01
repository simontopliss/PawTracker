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
        VStack {
            DismissButtonView()
                .padding([.top, .bottom, .trailing])

            Form {
                Group {
                    Section {
                        TextField("Name", text: $contact.name)
                            .fontWeight(.semibold)
                            .accessibilityIdentifier("CreateContactView_NameTextField")

                        TextField("Address", text: $contact.address, axis: .vertical)
                            .lineLimit(3...10)
                            .accessibilityIdentifier("CreateContactView_AddressTextField")

                        TextField("Post Code", text: $contact.postCode)
                            .accessibilityIdentifier("CreateContactView_PostCodeTextField")

                        TextField("Telephone", text: $contact.phoneNumber)
                            .accessibilityIdentifier("CreateContactView_TelephoneTextField")
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
                    .accessibilityIdentifier("CreateContactView_ValidatorErrorAlert_CancelButton")
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
