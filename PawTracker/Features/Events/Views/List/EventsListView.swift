//
//  EventsView.swift
//  PawTracker
//
//  Created by Simon Topliss on 18/03/2023.
//

import SwiftUI

struct EventsListView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var eventsViewModel: EventsViewModel
    @EnvironmentObject var petViewModel: PetViewModel

    @State private var showingAddScreen = false
    @State private var confirmationShown = false
    @State private var selectedEvent: Binding<Event>?

    // MARK: - BODY
    var body: some View {
        NavigationView {
            List {
                ForEach($eventsViewModel.uncompletedEvents) {event in
                    if let pet = petViewModel.findPetByID(event.petID.wrappedValue) {
                        NavigationLink {
                            EditEventView(event: event, pet: pet)
                        } label: {
                            EventListRowView(event: event, pet: pet)
                        }
                        .accessibilityIdentifier("EventsListView_NavigationLink")
                        .swipeActions {
                            Button(role: .none) {
                                selectedEvent = event
                                confirmationShown = true
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                            .fontDesign(.rounded)
                            .accessibilityIdentifier("EventsListView_SwipeDeleteButton")
                        }
                    }
                }
                .padding(.vertical, 2)
            }
            .confirmationDialog(
                "Are you sure?",
                isPresented: $confirmationShown
            ) {
                Button("Yes") {
                    if let event = selectedEvent {
                        withAnimation {
                            eventsViewModel.deleteEvent(event.id)
                        }
                    }
                }
            }
            .accessibilityIdentifier("EventsListView_List")
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Event", systemImage: "plus")
                            .fontDesign(.rounded)
                    }
                    .accessibilityIdentifier("EventsListView_AddButton")
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                CreateDailyFeedView()
            }
        }
    }
}

// MARK: - PREVIEW
struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsListView()
            .environmentObject(EventsViewModel())
            .environmentObject(PetViewModel())
    }
}
