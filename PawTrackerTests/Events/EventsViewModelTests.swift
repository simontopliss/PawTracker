@testable import PawTracker
import XCTest

final class EventsViewModelTests: XCTestCase {

    // swiftlint:disable:next implicitly_unwrapped_optional
    private var eventViewModel: EventsViewModel!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var events: [Event]!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var event: Event!

    override func setUpWithError() throws {
        try super.setUpWithError()
        eventViewModel = EventsViewModel()
        events = Event.mockEvents
        event = Event.mockEvent
    }

    override func tearDownWithError() throws {
        eventViewModel = nil
        events = nil
        event = nil
        try super.tearDownWithError()
    }

    func test_EventViewModel_loadsMockEvents() {
        XCTAssertFalse(eventViewModel.events.isEmpty, "EventViewModel should load the mock events")
        XCTAssertNotNil(event.id, "event.id should not be nil")
        XCTAssertEqual(event.date, isoDateAsDate("2023-05-27T14:29:52Z"))
        XCTAssertEqual(event.petID, UUID(uuidString: "08F40734-EFE6-4D75-B59A-37CD55948DBE"))
        XCTAssertEqual(event.subject, "2nd Vaccination")
    }

    func test_EventViewModel_savesEvents() {
        XCTAssertNoThrow(eventViewModel.saveEvents())
    }

    func test_AddEvent_increasesEventCount() {
        let eventCountBefore = eventViewModel.events.count
        let newEvent = createEvent()
        eventViewModel.addEvent(newEvent)
        let eventCountAfter = eventViewModel.events.count
        XCTAssertEqual(eventCountBefore + 1, eventCountAfter)
    }

    func test_UpdateEvent_isSuccessful() {
        event.subject = "Testing"
        eventViewModel.updateEvent(event)
        XCTAssertEqual(event.subject, "Testing")
    }

    func test_DeleteEvent_decreasesEventCount() {
        let eventCountBefore = eventViewModel.events.count
        // swiftlint:disable:next force_unwrapping
        eventViewModel.deleteEvent(eventViewModel.events.last!.id)
        let eventCountAfter = eventViewModel.events.count
        XCTAssertEqual(eventCountBefore - 1, eventCountAfter)
    }

    func test_FindEvent_findsEvent() {
        // swiftlint:disable:next force_unwrapping
        let foundEvent = eventViewModel.findEventByID(UUID(uuidString: "942F7AAF-9F8B-49E0-A82E-636E2704AC06")!)
        XCTAssertNotNil(foundEvent)
    }

    func createEvent() -> Event {
        let newEvent = Event(
            id: UUID(),
            date: Date(),
            // swiftlint:disable:next force_unwrapping
            petID: UUID(uuidString: "08F40734-EFE6-4D75-B59A-37CD55948DBE")!,
            subject: "Test Subject",
            // swiftlint:disable:next line_length
            notes: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        )
        return newEvent
    }
}
