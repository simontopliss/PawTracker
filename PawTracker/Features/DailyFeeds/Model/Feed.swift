//
//  Feed.swift
//  PawTracker
//
//  Created by Simon Topliss on 29/04/2023.
//

import Foundation

// MARK: - Feed
struct Feed: Equatable, Identifiable, Hashable {

    static func == (lhs: Feed, rhs: Feed) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var id: UUID
    var feedTimes: FeedTimes
    var feedTimesJoined: String? {
        var feeds: [String] = []
        if feedTimes.morning { feeds.append("Morning") }
        if feedTimes.lunch { feeds.append("Lunch") }
        if feedTimes.evening { feeds.append("Evening") }
        return feeds.isEmpty ? "" : feeds.joined(separator: ", ")
    }

    var petID: UUID
    var pet: Pet?
    var isFed: Bool
    var fedBy: String?
    var fedDate: Date?

    mutating func fed(_ fed: Bool, fedBy: String?) {
        isFed = fed
        self.fedBy = fedBy
        fedDate = Date()
    }

    mutating func addPet(_ pet: Pet) {
        self.pet = pet
    }
}

extension Feed {
    static let mockFeeds: [Feed] = Bundle.main.decode(Constants.JSONFiles.feeds)
    static let mockFeed = mockFeeds[0]
}

// MARK: - FeedTimes
struct FeedTimes: Codable {
    var morning, lunch, evening: Bool
}

extension Feed {
    enum FeedTime: String, Codable {
        case morning = "Morning"
        case lunch = "Lunch"
        case evening = "Evening"
    }
}

extension Feed {
    enum CodingKeys: String, CodingKey {
        case id
        case feedTimes = "feed_times"
        case petID = "pet_id"
        case isFed = "is_fed"
        case fedBy = "fed_by"
        case fedDate = "fed_date"
    }
}

extension Feed: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        feedTimes = try container.decode(FeedTimes.self, forKey: .feedTimes)
        petID = try container.decode(UUID.self, forKey: .petID)
        isFed = try container.decode(Bool.self, forKey: .isFed)
        fedBy = try container.decodeIfPresent(String.self, forKey: .fedBy)
        fedDate = try container.decodeIfPresent(Date.self, forKey: .fedDate)
    }
}

extension Feed: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(feedTimes, forKey: .feedTimes)
        try container.encode(petID, forKey: .petID)
        try container.encode(isFed, forKey: .isFed)
        try container.encodeIfPresent(fedBy, forKey: .fedBy)
        try container.encodeIfPresent(fedDate, forKey: .fedDate)
    }
}
