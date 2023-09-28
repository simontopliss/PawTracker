//
//  UpcomingEventsView.swift
//  PawTracker
//
//  Created by Simon Topliss on 19/03/2023.
//

import SwiftUI

struct UpcomingEventsView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var eventViewModel: EventsViewModel
    @EnvironmentObject var petViewModel: PetViewModel

    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading) {
            Text("Upcoming Events")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .font(.title3)
                .fontDesign(.rounded)
                .bold()
                .multilineTextAlignment(.leading)
                .foregroundColor(Constants.AppColors.textColor)
                .padding(.bottom, 1)
                .accessibilityIdentifier("UpcomingEventsTitle")

            Divider()
                .overlay(Constants.AppColors.textColor)
                .padding(.bottom, 2)

            ForEach($eventViewModel.events) { event in
                if let pet = petViewModel.findPetByID(event.petID.wrappedValue) {
                    EventRowView(event: event, pet: pet)
                }
            }

        }
        .padding(.bottom)
    }
}

struct UpcomingEventsView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingEventsView()
            .padding()
            .environmentObject(EventsViewModel())
            .environmentObject(PetViewModel())
    }
}
