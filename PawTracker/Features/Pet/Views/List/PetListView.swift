//
//  PetListView.swift
//  PawTracker
//
//  Created by Simon Topliss on 26/02/2023.
//

import SwiftUI

struct PetListView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var petViewModel: PetViewModel

    @State private var showingAddScreen = false
    @State private var confirmationShown = false
    @State private var selectedPet: Binding<Pet>?

    // MARK: - BODY
    var body: some View {
        NavigationView {
            List {
                ForEach($petViewModel.pets) { pet in
                    NavigationLink {
                        PetDetailView(pet: pet)
                    } label: {
                        PetListRowView(pet: pet)
                    }
                    .accessibilityIdentifier("PetListView_NavigationLink")
                    .swipeActions {
                        Button(role: .none) {
                            selectedPet = pet
                            confirmationShown = true
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                        .fontDesign(.rounded)
                        .accessibilityIdentifier("PetListView_SwipeDeleteButton")
                    }
                }
                .padding(.vertical, 2)
            }
            // confirmationDialog needs to go outside of the ForEach for it to work correctly
            // that's why we use selectedPet to keep track of the selected pet
            .confirmationDialog(
                "Are you sure?",
                isPresented: $confirmationShown
            ) {
                Button("Yes") {
                    if let pet = selectedPet {
                        withAnimation {
                            petViewModel.deletePet(pet.id)
                        }
                    }
                }
            }
            .accessibilityIdentifier("PetListView_List")
            .navigationTitle("My Pets")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Pet", systemImage: "plus")
                            .fontDesign(.rounded)
                    }
                    .accessibilityIdentifier("PetListView_AddPetButton")
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                CreatePetView()
            }
        }
    }
}

// MARK: - PREVIEW
struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
        PetListView()
            .environmentObject(PetViewModel())
    }
}
