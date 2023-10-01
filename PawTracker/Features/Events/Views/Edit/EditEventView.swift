//
//  EditEventView.swift
//  PawTracker
//
//  Created by Simon Topliss on 04/05/2023.
//

import SwiftUI

struct EditEventView: View {

    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var eventsViewModel: EventsViewModel
    @EnvironmentObject var petViewModel: PetViewModel

    @State private var showingRemoveAlert = false

    @State private var petNames: [String] = []
    @State private var selectedPetName: String?
    @State private var date = Date()

    @Binding var event: Event
    var pet: Pet

    // MARK: - BODY
    var body: some View {
        Form {
            Section {
                Picker("Pet", selection: $selectedPetName) {
                    ForEach(petNames, id: \.self) { name in
                        Text(name).tag(Optional(name))
                    }
                }
                .fontWeight(.bold)
                .accessibilityIdentifier("EditEventView_PetPicker")

                DatePicker(
                    "Date",
                    selection: $date,
                    in: Date()...,
                    displayedComponents: [.date]
                )
                .accessibilityIdentifier("EditEventView_DatePicker")

                TextField("Subject", text: $event.subject)
                    .accessibilityIdentifier("EditEventView_SubjectTextField")

                TextField("Notes", text: $event.notes, axis: .vertical)
                    .lineLimit(5...20)
                    .accessibilityIdentifier("EditEventView_NotesTextField")

                Toggle(isOn: $event.completed) {
                    Text("Completed")
                }
                .toggleStyle(SwitchToggleStyle())
                .accessibilityIdentifier("EditEventView_CompletedToggle")
            }
            .foregroundColor(Constants.AppColors.textColor)

            Section {
                Button("Submit") {
                    if let petName = selectedPetName,
                        let pet = petViewModel.findPetByName(petName) {
                        event.petID = pet.id
                        eventsViewModel.updateEvent(event)
                    }
                    dismiss()
                }
                .accessibilityIdentifier("EditPetView_SubmitButton")
            }
            .fontDesign(.rounded)
        }
        .navigationTitle("Edit Event")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingRemoveAlert = true
                } label: {
                    Text("\(Image(systemName: "trash"))")
                }
                .accessibilityIdentifier("EditEventView_DeleteButton")
            }
        }
        .alert("Delete event?", isPresented: $showingRemoveAlert) {
            Button("Delete", role: .destructive, action: deleteEvent)
                .fontDesign(.rounded)
                .accessibilityIdentifier("EditEventView_DeleteAlertButton")

            Button("Cancel", role: .cancel) {}
                .fontDesign(.rounded)
                .accessibilityIdentifier("EditEventView_CancelAlertButton")

        } message: {
            Text("Are you sure?")
                .fontDesign(.rounded)
                .accessibilityIdentifier("EditEventView_DeleteAlertMessage")
        }
        .onAppear {
            event.pet = petViewModel.findPetByID(event.petID)
            petNames = petViewModel.pets.map { $0.name }
            selectedPetName = petNames.first
        }
    }

    func deleteEvent() {
        eventsViewModel.deleteEvent(event.id)
    }
}

// MARK: - PREVIEW
struct EditEventView_Previews: PreviewProvider {
    static let event = Event.mockEvent
    static let pet = Pet.mockPet

    static var previews: some View {
        EditEventView(event: .constant(event), pet: pet)
            .environmentObject(EventsViewModel())
            .environmentObject(PetViewModel())
    }
}
