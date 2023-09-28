//
//  ContactListRowView.swift
//  PawTracker
//
//  Created by Simon Topliss on 05/05/2023.
//

import SwiftUI

struct ContactListRowView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @Binding var contact: Contact

    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading) {
            Text(contact.name)
                .font(.headline)
            Text(contact.phoneNumber)
                .font(.subheadline)
        }
        .fontDesign(.rounded)
        .lineLimit(1)
        .foregroundColor(Constants.AppColors.textColor)
    }
}

// MARK: - PREVIEW
struct ContactListRowView_Previews: PreviewProvider {
    static let contact = Contact.mockContact

    static var previews: some View {
        ContactListRowView(contact: .constant(contact))
            .padding()
    }
}
