//
//  PetDetailRowView.swift
//  PawTracker
//
//  Created by Simon Topliss on 17/03/2023.
//

import SwiftUI

struct PetDetailRowView: View {

    // MARK: - PROPERTIES
    let key: String
    let value: String

    // MARK: - BODY
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {

                Text(key)
                    .fontDesign(.rounded)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Constants.AppColors.textColor)
                    .frame(width: 120, alignment: .leading)
                    .accessibilityIdentifier("PetDetailRowView_\(key)")

                Text(value)
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Constants.AppColors.textColor)
                    .frame(
                        maxWidth: Constants.Onboarding.descriptionMaxWidth,
                        alignment: .leading
                    )
                    .padding(.leading, 2)
                    .accessibilityIdentifier("PetDetailRowView_\(key)_\(value)")
            }
            Divider()
                .overlay(.white)
        }
    }
}

// MARK: - PREVIEW
struct PetDetailRowView_Previews: PreviewProvider {
    static let pet = Pet.mockPet

    static var previews: some View {
        PetDetailRowView(
            key: "Type:",
            value: pet.type
        )
    }
}
