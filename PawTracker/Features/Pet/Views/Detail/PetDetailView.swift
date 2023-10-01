//
//  PetDetailView.swift
//  PawTracker
//
//  Created by Simon Topliss on 26/02/2023.
//

import SwiftUI

struct PetDetailView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var petViewModel: PetViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var isEditing = false
    @State private var showingRemoveAlert = false
    @State private var showingEditScreen = false

    @Binding var pet: Pet

    // MARK: - BODY
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                LargeTitleView(title: pet.name)
                    .accessibilityIdentifier("PetDetailView_PetName")

                PetDetailImageView(pet: pet)
                    .padding(.bottom, 12)
                    .accessibilityIdentifier("PetDetailView_ImageView")

                PetDetailInfoView(pet: pet)

                Spacer()
            }

        }
        .accessibilityIdentifier("PetDetailViewScrollView")
        .scrollIndicators(.hidden)
        .alert("Remove pet?", isPresented: $showingRemoveAlert) {
            Button("Remove", role: .destructive, action: removePet)
                .fontDesign(.rounded)
                .accessibilityIdentifier("PetDetail_RemovePetButton")
            Button("Cancel", role: .cancel) {}
                .fontDesign(.rounded)
                .accessibilityIdentifier("PetDetail_CancelRemovePetButton")
        } message: {
            Text("Are you sure?")
                .fontDesign(.rounded)
                .accessibilityIdentifier("PetDetail_RemovePetConfirmation")
        }
        .foregroundColor(Constants.AppColors.textColor)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    isEditing.toggle()
                    showingEditScreen.toggle()
                }
                .fontDesign(.rounded)
                .accessibilityIdentifier("PetDetail_EditButton")
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingRemoveAlert = true
                } label: {
                    Text("\(Image(systemName: "trash"))")
                }
                .accessibilityIdentifier("PetDetail_DeleteButton")
            }
        }
        .sheet(isPresented: $showingEditScreen) {
            EditPetView(pet: $pet)
        }
    }

    func removePet() {
        petViewModel.deletePet(pet.id)
    }
}

// MARK: - PREVIEW
struct PetDetailView_Previews: PreviewProvider {
    static let pet = Pet.mockPet

    static var previews: some View {
        NavigationView {
            PetDetailView(
                pet: .constant(pet)
            )
        }
    }
}
