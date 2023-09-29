//
//  HomeView.swift
//  PawTracker
//
//  Created by Simon Topliss on 17/02/2023.
//

import SwiftUI

struct HomeView: View {

    // MARK: - PROPERTIES
    @SceneStorage("showOnboardingView") private var showOnboardingView = false
    @EnvironmentObject var petViewModel: PetViewModel
    @EnvironmentObject var dailyFeedsViewModel: DailyFeedsViewModel

    @State private var expand = false

    // MARK: - BODY
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                VStack {
                    HomeHeaderView()
                    HomeImageView(expand: $expand)
                }
                OnboardingButton(showOnboardingView: $showOnboardingView)
            }

            ScrollView {
                UpcomingEventsView()
                TodayFeedsView()
            }
            .padding(.horizontal)

            Spacer()
        }
        .sheet(isPresented: $showOnboardingView) {
            OnboardingView(isPresented: $showOnboardingView)
                .accessibilityIdentifier("OnboardingViewSheet")
        }
    }
}

// MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(PetViewModel())
            .environmentObject(EventsViewModel())
            .environmentObject(DailyFeedsViewModel())
    }
}
