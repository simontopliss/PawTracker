//
//  EditDailyFeedView.swift
//  PawTracker
//
//  Created by Simon Topliss on 01/05/2023.
//

import SwiftUI

struct EditDailyFeedView: View {

    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var dailyFeedsViewModel: DailyFeedsViewModel
    @EnvironmentObject var petViewModel: PetViewModel

    @Binding var feed: Feed
    var pet: Pet

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack {
                        LargeTitleView(title: pet.name)
                        PetDetailImageView(pet: pet)
                    }
                }
                .listRowBackground(Color.clear)

                Group {
                    Section {
                        Toggle(isOn: $feed.feedTimes.morning) {
                            Text("Morning")
                        }
                        Toggle(isOn: $feed.feedTimes.lunch) {
                            Text("Lunch")
                        }
                        Toggle(isOn: $feed.feedTimes.evening) {
                            Text("Evening")
                        }
                        .toggleStyle(SwitchToggleStyle())
                    }
                    .foregroundColor(Constants.AppColors.textColor)

                    Section {
                        Button("Submit") {
                            dailyFeedsViewModel.updateFeed(feed)
                            dismiss()
                        }
                        .accessibilityIdentifier("EditPetView_SubmitButton")
                    }
                }
                .fontDesign(.rounded)
            }
            .navigationTitle("Edit Daily Feed")
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .fontDesign(.rounded)
                    .accessibilityIdentifier("EditPetView_CancelButton")
                }
            }
        }
    }
}

// MARK: - PREVIEW
struct EditDailyFeedView_Previews: PreviewProvider {
    static let feed = Feed.mockFeed
    static let pet = Pet.mockPet

    static var previews: some View {
        EditDailyFeedView(feed: .constant(feed), pet: pet)
            .environmentObject(DailyFeedsViewModel())
            .environmentObject(PetViewModel())
    }
}
