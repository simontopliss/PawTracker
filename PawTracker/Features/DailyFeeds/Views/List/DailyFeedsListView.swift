//
//  DailyFeedsListView.swift
//  PawTracker
//
//  Created by Simon Topliss on 29/04/2023.
//

import SwiftUI

struct DailyFeedsListView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var dailyFeedsViewModel: DailyFeedsViewModel
    @EnvironmentObject var petViewModel: PetViewModel

    @State private var showingAddScreen = false
    @State private var confirmationShown = false
    @State private var selectedFeed: Binding<Feed>?

    // MARK: - BODY
    var body: some View {
        NavigationView {
            List {
                ForEach($dailyFeedsViewModel.feeds) { feed in
                    if let pet = petViewModel.findPetByID(feed.petID.wrappedValue) {
                        NavigationLink {
                            EditDailyFeedView(feed: feed, pet: pet)
                        } label: {
                            DailyFeedListRowView(feed: feed, pet: pet)
                        }
                        .accessibilityIdentifier("DailyFeedsListView_NavigationLink")
                        .swipeActions {
                            Button(role: .none) {
                                selectedFeed = feed
                                confirmationShown = true
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                            .fontDesign(.rounded)
                            .accessibilityIdentifier("DailyFeedsListView_SwipeDeleteButton")
                        }
                    }
                }
            }
            .confirmationDialog(
                "Are you sure?",
                isPresented: $confirmationShown
            ) {
                Button("Yes") {
                    if let feed = selectedFeed {
                        withAnimation {
                            dailyFeedsViewModel.deleteFeed(feed.id)
                        }
                    }
                }
            }
            .accessibilityIdentifier("DailyFeedsListView_List")
            .navigationTitle("Daily Feeds")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Daily Feed", systemImage: "plus")
                            .fontDesign(.rounded)
                    }
                    .accessibilityIdentifier("DailyFeedsListView_AddButton")
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                CreateDailyFeedView()
            }
        }
    }
}

// MARK: - PREVIEW
struct FeedsListView_Previews: PreviewProvider {
    static var previews: some View {
        DailyFeedsListView()
            .environmentObject(DailyFeedsViewModel())
            .environmentObject(PetViewModel())
    }
}
