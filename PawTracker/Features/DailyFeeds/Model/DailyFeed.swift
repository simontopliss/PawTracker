//
//  DailyFeed.swift
//  PawTracker
//
//  Created by Simon Topliss on 02/05/2023.
//

import Foundation

struct DailyFeed: Equatable, Identifiable, Hashable {

    static func == (lhs: DailyFeed, rhs: DailyFeed) -> Bool {
        lhs.shortDate == rhs.shortDate
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var id: UUID

    var date: Date
    var shortDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: date)
    }

    var feedID: UUID
    var feed: Feed?
    var morning = false
    var lunch = false
    var evening = false

}

extension DailyFeed {
    static let mockDailyFeeds: [DailyFeed] = Bundle.main.decode(Constants.JSONFiles.dailyFeeds)
    static let mockDailyFeed = mockDailyFeeds[0]
}

extension DailyFeed {
    init(
        id: UUID = UUID(),
        date: Date,
        feedID: UUID,
        morning: Bool = false,
        lunch: Bool = false,
        evening: Bool = false
    ) {
        self.id = id
        self.date = date
        self.feedID = feedID
        self.morning = morning
        self.lunch = lunch
        self.evening = evening
    }
}

extension DailyFeed {
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case feedID = "feed_id"
        case feed
        case morning
        case lunch
        case evening
    }
}

extension DailyFeed: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.date = try container.decode(Date.self, forKey: .date)
        self.feedID = try container.decode(UUID.self, forKey: .feedID)
        self.feed = try container.decodeIfPresent(Feed.self, forKey: .feed)
        self.morning = try container.decode(Bool.self, forKey: .morning)
        self.lunch = try container.decode(Bool.self, forKey: .lunch)
        self.evening = try container.decode(Bool.self, forKey: .evening)
    }
}

extension DailyFeed: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.date, forKey: .date)
        try container.encode(self.feedID, forKey: .feedID)
        try container.encodeIfPresent(self.feed, forKey: .feed)
        try container.encode(self.morning, forKey: .morning)
        try container.encode(self.lunch, forKey: .lunch)
        try container.encode(self.evening, forKey: .evening)
    }
}
