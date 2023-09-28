//
//  EventViewModel.swift
//  PawTracker
//
//  Created by Simon Topliss on 23/03/2023.
//

import Foundation

final class EventsViewModel: ObservableObject {

    // MARK: - PROPERTIES

    @Published var events: [Event] = []
    @Published var uncompletedEvents: [Event] = []

    init() {
        events = loadEvents()
        uncompletedEvents = events.filter { $0.completed == false }
    }

    func loadEvents() -> [Event] {
        do {
            let userEventsJSON = FileManager.documentsDirectory
                .appendingPathComponent("events")
                .appendingPathExtension("json")
                .path

            let eventsJSONPath = FileManager.default.fileExists(atPath: userEventsJSON)
                ? userEventsJSON
                : Bundle.main.path(forResource: "events", ofType: "json")

            guard let eventsJSONPath,
                  let data = FileManager.default.contents(atPath: eventsJSONPath)
            // swiftlint:disable:previous indentation_width
            else {
                print("Unable to read JSON file.")
                return []
            }

            // print("Decoding from: \(eventsJSONPath)")

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let events = try decoder.decode([Event].self, from: data)

            return events

        } catch {
            print("loadEvents() error:" + String(describing: error))
            return []
        }
    }

    func saveEvents() {
        do {
            uncompletedEvents = events.filter { $0.completed == false }

            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            encoder.keyEncodingStrategy = .convertToSnakeCase
            encoder.outputFormatting = .prettyPrinted

            let data = try? encoder.encode(events)

            let savePath = FileManager.documentsDirectory
                .appendingPathComponent("events")
                .appendingPathExtension("json")

            try data?.write(to: savePath, options: [.atomic, .completeFileProtection])

        } catch {
            print("saveEvents() error:\n\(error.localizedDescription)")
        }
    }

    func addEvent(_ newEvent: Event) {
        events.append(newEvent)
        saveEvents()
    }

    func updateEvent(_ event: Event) {
        guard let index = events.firstIndex(where: { $0.id == event.id }) else {
            addEvent(event)
            return
        }
        events[index] = event
        saveEvents()
    }

    func deleteEvent(_ eventID: UUID) {
        events.removeAll { $0.id == eventID }
        saveEvents()
    }

    func findEventByID(_ eventID: UUID) -> Event? {
        events.first { $0.id == eventID }
    }
}
