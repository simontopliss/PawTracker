//
//  DailyFeedsViewModel.swift
//  PawTracker
//
//  Created by Simon Topliss on 29/04/2023.
//

import Foundation

final class DailyFeedsViewModel: ObservableObject {

    @Published var feeds: [Feed] = []
    @Published var dailyFeeds: [DailyFeed] = []
    @Published var todayDailyFeeds: [DailyFeed] = []

    init() {
        feeds = loadFeeds()
        dailyFeeds = loadDailyFeeds()
        todayDailyFeeds = dailyFeedsForDate()
    }

    // MARK: - FEEDS

    func loadFeeds() -> [Feed] {
        do {
            let userFeedsJSON = FileManager.documentsDirectory
                .appendingPathComponent("feeds")
                .appendingPathExtension("json")
                .path

            let feedsJSONPath = FileManager.default.fileExists(atPath: userFeedsJSON)
                ? userFeedsJSON
                : Bundle.main.path(forResource: "feeds", ofType: "json")

            guard let feedsJSONPath,
                  let data = FileManager.default.contents(atPath: feedsJSONPath)
            // swiftlint:disable:previous indentation_width
            else {
                print("Unable to read JSON file.")
                return []
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let feeds = try decoder.decode([Feed].self, from: data)

            return feeds

        } catch {
            print("loadFeeds() error:" + String(describing: error))
            return []
        }
    }

    func saveFeeds() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            encoder.keyEncodingStrategy = .convertToSnakeCase
            encoder.outputFormatting = .prettyPrinted

            let data = try? encoder.encode(feeds)

            let savePath = FileManager.documentsDirectory
                .appendingPathComponent("feeds")
                .appendingPathExtension("json")

            try data?.write(to: savePath, options: [.atomic, .completeFileProtection])

        } catch {
            print("saveFeeds() error:\n\(error.localizedDescription)")
        }
    }

    func deleteUserFeeds() {
        do {
            let jsonURL = FileManager.documentsDirectory
                .appendingPathComponent("feeds")
                .appendingPathExtension("json")
            if FileManager.default.fileExists(atPath: jsonURL.path) {
                try FileManager.default.removeItem(atPath: jsonURL.path)
            }
        } catch {
            print("deleteUserFeeds() error:\n" + String(describing: error))
        }
    }

    func addFeed(_ newFeed: Feed) {
        feeds.append(newFeed)
        saveFeeds()
    }

    func updateFeed(_ feed: Feed) {
        guard let index = feeds.firstIndex(where: { $0.id == feed.id }) else {
            addFeed(feed)
            return
        }
        feeds[index] = feed
        saveFeeds()
    }

    func deleteFeed(_ feedID: UUID) {
        feeds.removeAll { $0.id == feedID }
        saveFeeds()
    }

    func findFeedByID(_ feedID: UUID) -> Feed? {
        feeds.first { $0.id == feedID }
    }

    // MARK: - DAILY FEEDS

    func loadDailyFeeds() -> [DailyFeed] {
        do {
            let userDailyFeedsJSON = FileManager.documentsDirectory
                .appendingPathComponent("daily-feeds")
                .appendingPathExtension("json")
                .path

            let dailyFeedsJSONPath = FileManager.default.fileExists(atPath: userDailyFeedsJSON)
                ? userDailyFeedsJSON
                : Bundle.main.path(forResource: "daily-feeds", ofType: "json")

            guard let dailyFeedsJSONPath,
                  let data = FileManager.default.contents(atPath: dailyFeedsJSONPath)
            // swiftlint:disable:previous indentation_width
            else {
                print("Unable to read JSON file.")
                return []
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            var dailyFeeds = try decoder.decode([DailyFeed].self, from: data)

            for index in 0..<dailyFeeds.count {
                if let feed = findFeedByID(dailyFeeds[index].feedID) {
                    dailyFeeds[index].feed = feed
                }
            }

            return dailyFeeds

        } catch {
            print("loadDailyFeeds() error:\n" + String(describing: error))
            return []
        }
    }

    func saveDailyFeeds() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            encoder.keyEncodingStrategy = .convertToSnakeCase
            encoder.outputFormatting = .prettyPrinted

            let data = try? encoder.encode(dailyFeeds)

            let savePath = FileManager.documentsDirectory
                .appendingPathComponent("daily-feeds")
                .appendingPathExtension("json")

            try data?.write(to: savePath, options: [.atomic, .completeFileProtection])

        } catch {
            print("saveDailyFeeds() error:\n" + String(describing: error))
        }
    }

    func deleteUserDailyFeeds() {
        do {
            let jsonURL = FileManager.documentsDirectory
                .appendingPathComponent("daily-feeds")
                .appendingPathExtension("json")
            if FileManager.default.fileExists(atPath: jsonURL.path) {
                try FileManager.default.removeItem(atPath: jsonURL.path)
            }
        } catch {
            print("deleteUserDailyFeeds() error:\n" + String(describing: error))
        }
    }

    func addDailyFeed(_ newDailyFeed: DailyFeed) {
        dailyFeeds.append(newDailyFeed)
        saveDailyFeeds()
    }

    func updateDailyFeed(_ dailyFeed: DailyFeed) {
        guard let index = feeds.firstIndex(where: { $0.id == dailyFeed.id }) else {
            addDailyFeed(dailyFeed)
            return
        }
        dailyFeeds[index] = dailyFeed
        saveDailyFeeds()
    }

    func deleteDailyFeed(_ dailyFeedID: UUID) {
        dailyFeeds.removeAll { $0.id == dailyFeedID }
        saveDailyFeeds()
    }

    func dailyFeedsForDate(_ date: Date = Date()) -> [DailyFeed] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let shortDate = dateFormatter.string(from: date)
        var dayFeeds = dailyFeeds.filter { $0.shortDate == shortDate && $0.feed != nil }
        if dayFeeds.isEmpty {
            dayFeeds = createTodayFeeds()
        }
        return dayFeeds
    }

    func createTodayFeeds() -> [DailyFeed] {
        var todayFeeds: [DailyFeed] = []
        for feed in feeds {
            let newDailyFeed = DailyFeed(
                id: UUID(),
                date: Date(),
                feedID: feed.id,
                feed: feed,
                morning: false,
                lunch: false,
                evening: false
            )
            todayFeeds.append(newDailyFeed)
        }
        return todayFeeds
    }

    func isValidDailyFeed(_ dailyFeed: DailyFeed) -> Bool {
        dailyFeed.feed?.pet?.name != nil
    }

    func petNameForDailyFeed(_ dailyFeed: DailyFeed, pets: [Pet]) -> String {
        guard let feed = dailyFeed.feed else { return "Unknown Pet" }
        if let pet = pets.first(where: { $0.id == feed.petID }) {
            return pet.name
        }
        return "Unknown Pet"
    }
}
