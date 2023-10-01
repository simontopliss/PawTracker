//
//  EventListRowView.swift
//  PawTracker
//
//  Created by Simon Topliss on 04/05/2023.
//

import SwiftUI

struct EventListRowView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var eventsViewModel: EventsViewModel
    @EnvironmentObject var petViewModel: PetViewModel

    @Binding var event: Event
    var pet: Pet

    // MARK: - BODY
    var body: some View {
        HStack {

            PetListImageView(petImage: pet.petImage)

            VStack(alignment: .leading) {

                PetListPetNameView(pet: pet)

                Group {
                    Text(event.subject)
                        .fontWeight(.semibold)
                        .font(.subheadline)
                        .accessibilityIdentifier("EventSubject")

                    Text(event.datetime)
                        .font(.caption)
                        .accessibilityIdentifier("EventDateTime")
                }
                .fontDesign(.rounded)
                .lineLimit(1)
                .foregroundColor(Constants.AppColors.textColor)

            }
            .padding(.leading, 6)
        }
    }
}

// MARK: - PREVIEW
struct EventListRowView_Previews: PreviewProvider {
    static let event = Event.mockEvent
    static let pet = Pet.mockPet

    static var previews: some View {
        EventListRowView(event: .constant(event), pet: pet)
            .environmentObject(DailyFeedsViewModel())
            .environmentObject(PetViewModel())
    }
}
