//
//  DailyFeedListRowView.swift
//  PawTracker
//
//  Created by Simon Topliss on 29/04/2023.
//

import SwiftUI

struct DailyFeedListRowView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var dailyFeedsViewModel: DailyFeedsViewModel
    @EnvironmentObject var petViewModel: PetViewModel

    @Binding var feed: Feed
    var pet: Pet

    // MARK: - BODY
    var body: some View {
        HStack {

            PetListImageView(petImage: pet.petImage)

            VStack(alignment: .leading) {

                PetListPetNameView(pet: pet)

                Text(feed.feedTimesJoined ?? "Missing")
                    .font(.caption)
                    .fontDesign(.rounded)
                    .lineLimit(1)
                    .foregroundColor(Constants.AppColors.textColor)
            }
        }
    }
}

// MARK: - PREVIEW
struct DailyFeedListRowView_Previews: PreviewProvider {
    static let feed = Feed.mockFeed
    static let pet = Pet.mockPet

    static var previews: some View {
        DailyFeedListRowView(feed: .constant(feed), pet: pet)
            .environmentObject(DailyFeedsViewModel())
            .environmentObject(PetViewModel())
    }
}
