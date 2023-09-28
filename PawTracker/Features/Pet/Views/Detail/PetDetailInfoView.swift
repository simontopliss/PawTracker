//
//  PetDetailsView.swift
//  PawTracker
//
//  Created by Simon Topliss on 17/03/2023.
//

import SwiftUI

struct PetDetailInfoView: View {

    // MARK: - PROPERTIES
    let pet: Pet

    // MARK: - BODY
    var body: some View {
        VStack {
            PetDetailRowView(key: "Type:", value: pet.type)
            PetDetailRowView(key: "Breed:", value: pet.breed)
            PetDetailRowView(key: "Gender:", value: pet.gender)
            PetDetailRowView(key: "Weight:", value: "\(pet.weight) kg")
            PetDetailRowView(
                key: "Date of Birth:",
                value: pet.dateOfBirth?.formatted(date: .numeric, time: .omitted) ?? ""
            )

            VStack(alignment: .leading) {
                Text("Description:")
                    .fontDesign(.rounded)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Constants.AppColors.textColor)
                    .frame(width: 120, alignment: .leading)
                    .padding(.bottom, 1)
                    .accessibilityIdentifier("PetDetailRowView_DescriptionTitle")

                Text(pet.description)
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Constants.AppColors.textColor)
                    .frame(
                        maxWidth: Constants.Onboarding.descriptionMaxWidth,
                        alignment: .leading
                    )
                    .accessibilityIdentifier("PetDetailRowView_Description")
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .foregroundColor(Constants.AppColors.grayBoxColor)
                .shadow(
                    color: Constants.Shadows.shadowColor,
                    radius: Constants.Shadows.largeRadius,
                    x: Constants.Shadows.largeX,
                    y: Constants.Shadows.largeY
                )
        )
        .padding(.horizontal)
    }
}

// MARK: - PREVIEW
struct PetDetailsView_Previews: PreviewProvider {
    static let pet = Pet.mockPet

    static var previews: some View {
        PetDetailInfoView(pet: pet)
    }
}
