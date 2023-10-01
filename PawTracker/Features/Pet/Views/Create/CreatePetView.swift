//
//  CreatePetView.swift
//  PawTracker
//
//  Created by Simon Topliss on 02/04/2023.
//

import SwiftUI

struct CreatePetView: View {

    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var petViewModel: PetViewModel

    @State private var date = Date()
    @State private var pet = Pet(
        id: UUID(),
        modDate: Date(),
        name: "",
        type: "",
        breed: "",
        gender: Pet.Gender.unknown.rawValue,
        weight: 0.0,
        description: "",
        petImage: UIImage(named: Constants.General.blankPetImage)! // swiftlint:disable:this force_unwrapping
    )

    // MARK: - BODY
    var body: some View {
        VStack {
            DismissButtonView()
                .padding([.top, .bottom, .trailing])

            Form {
                Section {
                    EditablePetImageView(pet: $pet)
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
                            petViewModel.validatePet(pet)
                            if petViewModel.hasValidatorError == false {
                                petViewModel.addPet(pet)
                                dismiss()
                            }
                        }
                        .accessibilityIdentifier("CreatePetView_SubmitButton")
                    }
                }
                .fontDesign(.rounded)
            }
            .alert(isPresented: $petViewModel.hasValidatorError, error: petViewModel.validatorError) {
                Button("Cancel", role: .cancel) {}
            }
            .navigationTitle("Add Pet")
        }
    }
}

// MARK: - PREVIEW
struct CreateNewPetView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePetView()
            .environmentObject(PetViewModel())
    }
}

extension CreatePetView {
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

private extension CreatePetView {

    var name: some View {
        TextField("Pet Name", text: $pet.name)
            .accessibilityIdentifier("CreatePetView_Name")
    }

    var type: some View {
        TextField("Type", text: $pet.type)
            .accessibilityIdentifier("CreatePetView_Type")
    }

    var breed: some View {
        TextField("Breed", text: $pet.breed)
            .accessibilityIdentifier("CreatePetView_Breed")
    }

    var gender: some View {
        Picker("Gender", selection: $pet.gender) {
            ForEach(Pet.Gender.allCases, id: \.self) { gender in
                Text(gender.rawValue).tag(gender.rawValue)
            }
        }
        .accessibilityIdentifier("CreatePetView_Gender")
    }

    var weight: some View {
        TextField("Weight", value: $pet.weight, format: .number)
            .accessibilityIdentifier("CreatePetView_Weight")
    }

    var dateOfBirth: some View {
        DatePicker(
            "Date of Birth",
            selection: $date,
            in: ...Date(),
            displayedComponents: [.date]
        )
        .accessibilityIdentifier("CreatePetView_DateOfBirth")
    }

    var description: some View {
        TextField("Description", text: $pet.description, axis: .vertical)
            .lineLimit(5...10)
            .accessibilityIdentifier("CreatePetView_Description")
    }
}
