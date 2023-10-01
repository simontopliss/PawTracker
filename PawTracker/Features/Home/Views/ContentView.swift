//
//  ContentView.swift
//  Landmarks
//
//  Created by Simon Topliss on 16/03/2023.
//

import SwiftUI

struct ContentView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var petViewModel: PetViewModel
    @EnvironmentObject var dailyFeedsViewModel: DailyFeedsViewModel

    @SceneStorage("tabSelection") private var tabSelection = Tab.home

    // MARK: - BODY
    var body: some View {

        TabView(selection: $tabSelection) {

            HomeView()
                .tabItem {
                    Label(Tab.home.label, systemImage: Tab.home.icon)
                        .fontDesign(.rounded)
                        .accessibilityIdentifier("HomeViewTab")
                }
                .tag(Tab.home)

            PetListView()
                .badge(petViewModel.pets.count)
                .tabItem {
                    Label(Tab.pets.label, systemImage: Tab.pets.icon)
                        .fontDesign(.rounded)
                        .accessibilityIdentifier("PetListViewTab")
                }
                .tag(Tab.pets)

            EventsListView()
                .tabItem {
                    Label(Tab.events.label, systemImage: Tab.events.icon)
                        .fontDesign(.rounded)
                        .accessibilityIdentifier("EventsListViewTab")
                }
                .tag(Tab.events)

            DailyFeedsListView()
                .tabItem {
                    Label(Tab.dailyFeeds.label, systemImage: Tab.dailyFeeds.icon)
                        .fontDesign(.rounded)
                        .accessibilityIdentifier("DailyFeedsListViewTab")
                }
                .tag(Tab.dailyFeeds)

            ContactsListView()
                .tabItem {
                    Label(Tab.contacts.label, systemImage: Tab.contacts.icon)
                        .fontDesign(.rounded)
                        .accessibilityIdentifier("ContactsListViewTab")
                }
                .tag(Tab.contacts)
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PetViewModel())
            .environmentObject(DailyFeedsViewModel())
            .environmentObject(EventsViewModel())
            .environmentObject(ContactsViewModel())
    }
}
