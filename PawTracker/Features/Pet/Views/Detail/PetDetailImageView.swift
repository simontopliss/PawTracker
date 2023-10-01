//
//  PetDetailImageView.swift
//  PawTracker
//
//  Created by Simon Topliss on 17/03/2023.
//

import SwiftUI

struct PetDetailImageView: View {

    // MARK: - PREVIEW
    var pet: Pet

    // MARK: - BODY
    var body: some View {
        Image(uiImage: pet.petImage)
            .resizable()
            .scaledToFit()
            .clipShape(Constants.ClipShapes.largeRoundedRectangle)
            .shadow(
                color: Constants.Shadows.shadowColor,
                radius: Constants.Shadows.largeRadius,
                x: Constants.Shadows.largeX,
                y: Constants.Shadows.largeY
            )
            .padding(.horizontal)
            .accessibilityIdentifier("PetDetailImageView")
    }
}

// MARK: - PREVIEW
struct PetDetailImageView_Previews: PreviewProvider {
    static let pet = Pet.mockPet

    static var previews: some View {
        PetDetailImageView(pet: pet)
    }
}
