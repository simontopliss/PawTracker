//
//  TodayFeedsView.swift
//  PawTracker
//
//  Created by Simon Topliss on 19/03/2023.
//

import SwiftUI

struct TodayFeedsView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var dailyFeedsViewModel: DailyFeedsViewModel
    @EnvironmentObject var petViewModel: PetViewModel

    @State private var date = Date()

    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            TodayFeedsColumnsHeader()

            Divider()
                .overlay(Constants.AppColors.textColor)
                .padding(.bottom, 2)

            ForEach($dailyFeedsViewModel.todayDailyFeeds) { dailyFeed in
                HStack {
                    Text(petNameForDailyFeed(dailyFeed.wrappedValue))
                        .font(.title3)
                        .kerning(Constants.TextStyle.kerning)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .frame(width: 140, alignment: .leading)
                        .accessibilityIdentifier("TodayFeedsView_PetName")

                    FeedStatusView(status: dailyFeed.morning)
                        .accessibilityIdentifier("FeedStatusView_Morning")

                    Spacer()

                    FeedStatusView(status: dailyFeed.lunch)
                        .accessibilityIdentifier("FeedStatusView_Lunch")

                    Spacer()

                    FeedStatusView(status: dailyFeed.evening)
                        .accessibilityIdentifier("FeedStatusView_Evening")

                    Spacer()
                }
            }
            .fontDesign(.rounded)
            .multilineTextAlignment(.leading)
            .foregroundColor(Constants.AppColors.textColor)
        }
    }

    func petNameForDailyFeed(_ dailyFeed: DailyFeed) -> String {
        guard let feed = dailyFeed.feed else { return "Unknown Pet" }
        if let pet = petViewModel.pets.first(where: { $0.id == feed.petID }) {
            return pet.name
        }
        return "Unknown Pet"
    }
}

// MARK: - PREVIEW
struct DailyFeedsView_Previews: PreviewProvider {
    static let feeds = Feed.mockFeeds
    static let pets = Pet.mockPets

    static var previews: some View {
        TodayFeedsView()
            .padding()
            .environmentObject(PetViewModel())
            .environmentObject(DailyFeedsViewModel())
    }
}
