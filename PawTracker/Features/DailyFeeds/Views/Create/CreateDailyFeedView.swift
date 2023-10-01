//
//  CreateDailyFeedView.swift
//  PawTracker
//
//  Created by Simon Topliss on 29/04/2023.
//

import SwiftUI

struct CreateDailyFeedView: View {

    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var dailyFeedsViewModel: DailyFeedsViewModel
    @EnvironmentObject var petViewModel: PetViewModel

    @State private var petNames: [String] = []
    @State private var selectedPetName: String?
    @State private var morning = false
    @State private var lunch = false
    @State private var evening = false

    // MARK: - BODY
    var body: some View {
        Form {
            Group {
                Section {
                    Picker("Pet", selection: $selectedPetName) {
                        ForEach(petNames, id: \.self) { name in
                            Text(name).tag(Optional(name))
                                .accessibilityIdentifier("CreateDailyFeedView_PetName")
                        }
                    }
                    .fontWeight(.bold)
                    .accessibilityIdentifier("CreateDailyFeedView_PetPicker")

                    Toggle(isOn: $morning) {
                        Text("Morning")
                    }
                    .accessibilityIdentifier("CreateDailyFeedView_MorningToggle")

                    Toggle(isOn: $lunch) {
                        Text("Lunch")
                    }
                    .accessibilityIdentifier("CreateDailyFeedView_LunchToggle")

                    Toggle(isOn: $evening) {
                        Text("Evening")
                    }
                    .accessibilityIdentifier("CreateDailyFeedView_EveningToggle")
                }
                .toggleStyle(SwitchToggleStyle())
                .foregroundColor(Constants.AppColors.textColor)

                Section {
                    Button("Submit") {
                        if let petName = selectedPetName,
                            let pet = petViewModel.findPetByName(petName) {
                            let feed = Feed(
                                id: UUID(),
                                feedTimes:
                                    FeedTimes(
                                        morning: morning,
                                        lunch: lunch,
                                        evening: evening
                                    ),
                                petID: pet.id,
                                isFed: false
                            )
                            dailyFeedsViewModel.addFeed(feed)
                        }
                        dismiss()
                    }
                    .accessibilityIdentifier("CreateDailyFeedView_SubmitButton")
                }
            }
            .fontDesign(.rounded)
        }
        .navigationTitle("Create Daily Feed")
        .onAppear {
            petNames = petViewModel.pets.map { $0.name }
            selectedPetName = petNames.first
        }
    }
}

// MARK: - PREVIEW
struct CreateDailyFeedView_Previews: PreviewProvider {
    static var previews: some View {
        CreateDailyFeedView()
            .environmentObject(DailyFeedsViewModel())
            .environmentObject(PetViewModel())
    }
}
