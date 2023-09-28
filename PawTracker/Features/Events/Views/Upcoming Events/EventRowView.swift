//
//  EventRowView.swift
//  PawTracker
//
//  Created by Simon Topliss on 05/05/2023.
//

import SwiftUI

struct EventRowView: View {

    // MARK: - PROPERTIES
    @Binding var event: Event
    var pet: Pet

    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading) {

            HStack(alignment: .firstTextBaseline) {

                Text(pet.name)
                    .accessibilityIdentifier("EventPetName")

                Text("•")

                Text(event.subject)
                    .accessibilityIdentifier("EventSubject")

            }
            .font(.subheadline)
            .fontWeight(.semibold)

            Text(event.datetime)
                .font(.footnote)
                .accessibilityIdentifier("EventDateTime")

        }
        .fontDesign(.rounded)
        .multilineTextAlignment(.leading)
        .foregroundColor(Constants.AppColors.textColor)
        .padding(.bottom, 1)
    }
}

// MARK: - PREVIEW
struct EventRowView_Previews: PreviewProvider {
    static let event = Event.mockEvent
    static let pet = Pet.mockPet

    static var previews: some View {
        EventRowView(event: .constant(event), pet: pet)
            .environmentObject(EventsViewModel())
            .environmentObject(PetViewModel())
    }
}
