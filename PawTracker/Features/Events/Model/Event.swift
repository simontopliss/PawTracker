//
//  Event.swift
//  PawTracker
//
//  Created by Simon Topliss on 23/03/2023.
//

import Foundation

struct Event: Equatable, Identifiable, Hashable, Codable {

    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var id: UUID
    var date: Date
    var petID: UUID
    var subject: String
    var notes: String
    var completed = false

    var pet: Pet?

    var datetime: String {
        date.formatted(date: .complete, time: .shortened)
    }
}

extension Event {
    static let mockEvents: [Event] = Bundle.main.decode(Constants.JSONFiles.events)
    static let mockEvent = mockEvents[0]
}

extension Event {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.date = try container.decode(Date.self, forKey: .date)
        self.petID = try container.decode(UUID.self, forKey: .petID)
        self.subject = try container.decode(String.self, forKey: .subject)
        self.notes = try container.decode(String.self, forKey: .notes)
        self.completed = try container.decode(Bool.self, forKey: .completed)
    }
}

extension Event {
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case petID = "pet_id"
        case subject
        case notes
        case completed
    }
}

extension Event {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.date, forKey: .date)
        try container.encode(self.petID, forKey: .petID)
        try container.encode(self.subject, forKey: .subject)
        try container.encode(self.notes, forKey: .notes)
        try container.encode(self.completed, forKey: .completed)
    }
}
