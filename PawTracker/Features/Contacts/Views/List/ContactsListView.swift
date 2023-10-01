//
//  ContactsListView.swift
//  PawTracker
//
//  Created by Simon Topliss on 18/03/2023.
//

import SwiftUI

struct ContactsListView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var contactsViewModel: ContactsViewModel

    @State private var showingAddScreen = false
    @State private var confirmationShown = false
    @State private var selectedContact: Binding<Contact>?

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            List {
                ForEach($contactsViewModel.contacts) { contact in
                    NavigationLink {
                        EditContactView(contact: contact)
                    } label: {
                        ContactListRowView(contact: contact)
                    }
                    .accessibilityIdentifier("ContactsListView_NavigationLink")
                    .swipeActions {
                        Button(role: .none) {
                            selectedContact = contact
                            confirmationShown = true
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                        .fontDesign(.rounded)
                        .accessibilityIdentifier("ContactsListView_SwipeDeleteButton")
                    }
                }
            }
            .accessibilityIdentifier("ContactsListView_List")
            .confirmationDialog("Are you sure?", isPresented: $confirmationShown) {
                Button("Yes") {
                    if let contact = selectedContact {
                        withAnimation {
                            contactsViewModel.deleteContact(contact.id)
                        }
                    }
                }
                .accessibilityIdentifier("ContactsListView_ConfirmationDialog_YesButton")
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Contact", systemImage: "plus.circle.fill")
                            .fontDesign(.rounded)
                    }
                    .accessibilityIdentifier("ContactsListView_AddButton")
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                CreateContactView()
            }
        }
    }
}

// MARK: - PREVIEW
struct Contacts_Previews: PreviewProvider {
    static var previews: some View {
        ContactsListView()
            .environmentObject(ContactsViewModel())
    }
}
