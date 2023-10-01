//
//  CreateEventView.swift
//  PawTracker
//
//  Created by Simon Topliss on 05/05/2023.
//

import SwiftUI

struct CreateEventView: View {

    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var eventsViewModel: EventsViewModel
    @EnvironmentObject var petViewModel: PetViewModel

    @State private var petNames: [String] = []
    @State private var selectedPetName: String?
    @State private var date = Date()
    @State private var subject = ""
    @State private var notes = ""

    // MARK: - BODY
    var body: some View {
        Form {
            Group {
                Section {
                    Picker("Pet", selection: $selectedPetName) {
                        ForEach(petNames, id: \.self) { name in
                            Text(name).tag(Optional(name))
                                .accessibilityIdentifier("CreateEventView_PetName")
                        }
                    }
                    .accessibilityIdentifier("CreateEventView_PetPicker")
                    .fontWeight(.bold)

                    DatePicker(
                        "Date",
                        selection: $date,
                        in: Date()...,
                        displayedComponents: [.date]
                    )
                    .accessibilityIdentifier("CreateEventView_DatePicker")

                    TextField("Subject", text: $subject)
                        .accessibilityIdentifier("CreateEventView_SubjectTextField")

                    TextField("Notes", text: $notes, axis: .vertical)
                        .lineLimit(5...20)
                        .accessibilityIdentifier("CreateEventView_NotesTextField")
                }
                .foregroundColor(Constants.AppColors.textColor)

                Section {
                    Button("Submit") {
                        if let petName = selectedPetName,
                            let pet = petViewModel.findPetByName(petName) {
                            let event = Event(
                                id: UUID(),
                                date: date,
                                petID: pet.id,
                                subject: subject,
                                notes: notes
                            )
                            eventsViewModel.addEvent(event)
                        }
                        dismiss()
                    }
                    .accessibilityIdentifier("CreateEventView_SubmitButton")
                }
            }
            .fontDesign(.rounded)
        }
        .navigationTitle("Create Event")
        .onAppear {
            petNames = petViewModel.pets.map { $0.name }
            selectedPetName = petNames.first
        }
    }
}

// MARK: - PREVIEW
struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
            .environmentObject(EventsViewModel())
            .environmentObject(PetViewModel())
    }
}
