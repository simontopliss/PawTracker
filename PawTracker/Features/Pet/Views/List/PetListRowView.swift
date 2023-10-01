//
//  PetListRowView.swift
//  PawTracker
//
//  Created by Simon Topliss on 12/03/2023.
//

import SwiftUI

struct PetListRowView: View {

    // MARK: - PROPERTIES
    @Binding var pet: Pet

    // MARK: - BODY
    var body: some View {
        HStack {

            PetListImageView(petImage: pet.petImage)

            VStack(alignment: .leading) {
                PetListPetNameView(pet: pet)

                if pet.breed.isEmpty {
                    Text(pet.type)
                        .font(.footnote)
                        .fontDesign(.rounded)
                        .lineLimit(1)
                        .foregroundColor(Constants.AppColors.textColor)
                        .accessibilityIdentifier("PetListRowView_PetType")
                } else {
                    Text("\(pet.type), \(pet.breed)")
                        .font(.footnote)
                        .fontDesign(.rounded)
                        .lineLimit(1)
                        .foregroundColor(Constants.AppColors.textColor)
                        .accessibilityIdentifier("PetListRowView_PetTypeAndBreed")
                }

                if pet.dateOfBirth != nil {
                    Text(formatAge(pet.dateOfBirth!)) // swiftlint:disable:this force_unwrapping
                        .font(.caption)
                        .fontDesign(.rounded)
                        .lineLimit(1)
                        .foregroundColor(
                            isBirthdayToday(pet.dateOfBirth!) // swiftlint:disable:this force_unwrapping
                            ? .red
                            : Constants.AppColors.textColor
                        )
                        .accessibilityIdentifier("PetListRowView_PetAge")
                }

            }
            .padding(.leading, 6)
        }
    }
}

// MARK: - PREVIEW
struct PetListRowView_Previews: PreviewProvider {
    static let pet = Pet.mockPet

    static var previews: some View {
        PetListRowView(pet: .constant(pet))
            .environmentObject(PetViewModel())
            .previewLayout(.sizeThatFits)
    }
}
