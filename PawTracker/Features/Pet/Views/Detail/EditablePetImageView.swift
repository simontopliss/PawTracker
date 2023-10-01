//
//  EditablePetImageView.swift
//  PhotosPickerExample
//
//  Created by Simon Topliss on 25/04/2023.
//

import PhotosUI
import SwiftUI

struct EditablePetImageView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var petViewModel: PetViewModel
    @Binding var pet: Pet

    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?

    // MARK: - BODY
    var body: some View {

        Image(uiImage: $pet.petImage.wrappedValue)
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
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .any(of: [.images, .not(.screenshots)]),
                    photoLibrary: .shared()
                ) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                        .foregroundColor(.accentColor)
                }
                .onChange(of: selectedItem) { _, newItem in
                    Task {
                        // Retrieve selected asset in the form of Data
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            selectedImageData = data

                            if let selectedImageData,
                               let uiImage = UIImage(data: selectedImageData) {
                                // swiftlint:disable:previous indentation_width
                                petViewModel.savePetImage(pet: &pet, image: uiImage)
                                return
                            }
                        }
                    }
                }
            }
            .accessibilityIdentifier("EditablePetImageView")
    }
}

// MARK: - PREVIEW
struct EditablePetImageView_Previews: PreviewProvider {
    static let pet = Pet.mockPet

    static var previews: some View {
        EditablePetImageView(pet: .constant(pet))
    }
}
