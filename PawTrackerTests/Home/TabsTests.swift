@testable import PawTracker
import XCTest

final class TabsTests: XCTestCase {

    func test_TabsLabel() {
        XCTAssertEqual(Tab.home.label, "Home")
        XCTAssertEqual(Tab.pets.label, "Pets")
        XCTAssertEqual(Tab.contacts.label, "Contacts")
        XCTAssertEqual(Tab.events.label, "Events")
        XCTAssertEqual(Tab.gallery.label, "Gallery")
        XCTAssertEqual(Tab.dailyFeeds.label, "Feeds")
    }

    func test_TabsIcon() {
        XCTAssertEqual(Tab.home.icon, "house.fill")
        XCTAssertEqual(Tab.pets.icon, "list.bullet")
        XCTAssertEqual(Tab.contacts.icon, "phone.circle.fill")
        XCTAssertEqual(Tab.events.icon, "calendar")
        XCTAssertEqual(Tab.gallery.icon, "photo.stack")
        XCTAssertEqual(Tab.dailyFeeds.icon, "fork.knife.circle.fill")
    }
}
