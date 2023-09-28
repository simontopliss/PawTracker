//
//  PetListPetNameView.swift
//  PhotosPickerExample
//
//  Created by Simon Topliss on 24/04/2023.
//

import SwiftUI

struct PetListPetNameView: View {

    // MARK: - PROPERTIES
    var pet: Pet

    // MARK: - BODY
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(pet.name)
                .font(.title2)
                .kerning(Constants.TextStyle.kerning)
                .fontDesign(.rounded)
                .fontWeight(.bold)
                .foregroundColor(Constants.AppColors.brandPrimary)
                .accessibilityLabel("PetName")

            if pet.dateOfBirth != nil {
                if isBirthdayToday(pet.dateOfBirth!) { // swiftlint:disable:this force_unwrapping
                    Text("\(Image(systemName: "birthday.cake.fill"))")
                        .foregroundColor(.red)
                        .offset(y: -2)
                }
            }
        }
    }
}

// MARK: - PROPERTIES
struct PetListPetNameView_Previews: PreviewProvider {
    static let pet = Pet.mockPet

    static var previews: some View {
        PetListPetNameView(pet: pet)
            .environmentObject(PetViewModel())
            .previewLayout(.sizeThatFits)
    }
}
