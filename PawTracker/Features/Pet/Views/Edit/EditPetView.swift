//
//  EditPetView.swift
//  PawTracker
//
//  Created by Simon Topliss on 02/04/2023.
//

import SwiftUI

struct EditPetView: View {

    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var petViewModel: PetViewModel

    @Binding var pet: Pet

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        EditablePetImageView(pet: $pet)
                    }
                }
                .listRowBackground(Color.clear)
                .padding([.top], 10)

                Group {
                    Section {
                        name
                        type
                        breed
                        gender
                        weight
                        dateOfBirth
                        description
                    }
                    .foregroundColor(Constants.AppColors.textColor)

                    Section {
                        Button("Submit") {
                            pet.modDate = Date()
                            petViewModel.validatePet(pet)
                            if petViewModel.hasValidatorError == false {
                                petViewModel.updatePet(pet)
                                dismiss()
                            }
                        }
                        .accessibilityIdentifier("EditPetView_SubmitButton")
                    }

                }
                .fontDesign(.rounded)

            }
            .alert(isPresented: $petViewModel.hasValidatorError, error: petViewModel.validatorError) {
                Button("Cancel", role: .cancel) {}
            }
            .navigationTitle("Edit Pet")
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .fontDesign(.rounded)
                    .accessibilityIdentifier("EditPetView_CancelButton")
                }
            }
        }
    }
}

extension EditPetView {
    enum Field: Hashable {
        case name
        case type
        case breed
        case gender
        case weight
        case dateOfBirth
        case description
    }
}

private extension EditPetView {

    var name: some View {
        TextField("Pet Name", text: $pet.name)
            .accessibilityIdentifier("EditPetView_Name")
    }

    var type: some View {
        TextField("Type", text: $pet.type)
            .accessibilityIdentifier("EditPetView_Type")
    }

    var breed: some View {
        TextField("Type", text: $pet.breed)
            .accessibilityIdentifier("EditPetView_Breed")
    }

    var gender: some View {
        Picker("Gender", selection: $pet.gender) {
            ForEach(Pet.Gender.allCases, id: \.self) { gender in
                Text(gender.rawValue).tag(gender.rawValue)
            }
        }
        .accessibilityIdentifier("EditPetView_Gender")
    }

    var weight: some View {
        TextField("Weight", value: $pet.weight, format: .number)
            .accessibilityIdentifier("EditPetView_Weight")
    }

    var dateOfBirth: some View {
        DatePicker(
            "Date of Birth",
            selection: $pet.dateOfBirth.defaultValue(Date()),
            in: ...Date(),
            displayedComponents: [.date]
        )
        .accessibilityIdentifier("EditPetView_DateOfBirth")
    }

    var description: some View {
        TextField("Description", text: $pet.description, axis: .vertical)
            .lineLimit(5...10)
            .accessibilityIdentifier("EditPetView_Description")
    }
}

// MARK: - PREVIEW
struct EditPetView_Previews: PreviewProvider {
    static let pet = Pet.mockPet

    static var previews: some View {
        EditPetView(pet: .constant(pet))
            .environmentObject(PetViewModel())
    }
}
