//
//  PetListImageView.swift
//  PhotosPickerExample
//
//  Created by Simon Topliss on 24/04/2023.
//

import SwiftUI

struct PetListImageView: View {

    // MARK: - PROPERTIES
    var petImage: UIImage

    // MARK: - BODY
    var body: some View {
        Image(uiImage: petImage)
            .resizable()
            .scaledToFill()
            .frame(width: 70, height: 70)
            .clipShape(Constants.ClipShapes.smallRoundedRectangle)
            .shadow(
                color: Constants.Shadows.shadowColor,
                radius: Constants.Shadows.smallRadius,
                x: Constants.Shadows.smallX,
                y: Constants.Shadows.smallY
            )
            .accessibilityIdentifier("PetListImageView")
    }
}

// MARK: - PREVIEW
struct PetListImageView_Previews: PreviewProvider {
    static let pet = Pet.mockPet

    static var previews: some View {
        PetListImageView(petImage: pet.petImage)
    }
}
