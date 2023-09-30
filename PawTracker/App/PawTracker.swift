//
//  PawTracker.swift
//  PawTracker
//
//  Created by Simon Topliss on 17/02/2023.
//

import SwiftUI

@main
struct PawTracker: App {

    // MARK: - PROPERTIES
    @StateObject var petViewModel   = PetViewModel()
    @StateObject var eventViewModel = EventsViewModel()
    @StateObject var dailyFeedsViewModel = DailyFeedsViewModel()
    @StateObject var contactsViewModel = ContactsViewModel()

    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(petViewModel)
                .environmentObject(eventViewModel)
                .environmentObject(dailyFeedsViewModel)
                .environmentObject(contactsViewModel)
        }
    }
}
