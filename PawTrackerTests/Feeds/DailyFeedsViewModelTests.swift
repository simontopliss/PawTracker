@testable import PawTracker
import XCTest

final class DailyFeedsViewModelTests: XCTestCase {

    // swiftlint:disable:next implicitly_unwrapped_optional
    private var dailyFeedsViewModel: DailyFeedsViewModel!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var feeds: [Feed]!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var feed: Feed!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var dailyFeeds: [DailyFeed]!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var dailyFeed: DailyFeed!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var todayDailyFeeds: [DailyFeed]!

    override func setUpWithError() throws {
        try super.setUpWithError()
        dailyFeedsViewModel = DailyFeedsViewModel()
        feeds = Feed.mockFeeds
        feed = Feed.mockFeed
        dailyFeeds = DailyFeed.mockDailyFeeds
        dailyFeed = DailyFeed.mockDailyFeed
    }

    override func tearDownWithError() throws {
        dailyFeedsViewModel.deleteUserFeeds()
        dailyFeedsViewModel.deleteUserDailyFeeds()
        feeds = nil
        feed = nil
        dailyFeeds = nil
        dailyFeed = nil
        dailyFeedsViewModel = nil
        try super.tearDownWithError()
    }

    func test_DailyFeedsViewModel_loadsDailyFeeds() {
        XCTAssertFalse(dailyFeedsViewModel.dailyFeeds.isEmpty, "DailyFeedsViewModel should load the mock daily feeds")
        XCTAssertNotNil(dailyFeed.id, "dailyFeed.id should not be nil")
        XCTAssertEqual(dailyFeed.date, isoDateAsDate("2023-04-28T00:00:00Z"))
        // swiftlint:disable:next force_unwrapping
        XCTAssertEqual(dailyFeed.feedID, UUID(uuidString: "E16FB84E-3A4A-4108-8621-9D6F7E6BDBF0")!)
        XCTAssertEqual(dailyFeeds.count, 35)
    }

    func test_DailyFeedsViewModel_savesDailyFeeds() {
        XCTAssertNoThrow(dailyFeedsViewModel.saveDailyFeeds())
    }

    func test_AddDailyFeed_increasesDailyFeedCount() {
        let dailyFeedCountBefore = dailyFeedsViewModel.dailyFeeds.count
        let newDailyFeed = createDailyFeed()
        dailyFeedsViewModel.addDailyFeed(newDailyFeed)
        let dailyFeedCountAfter = dailyFeedsViewModel.dailyFeeds.count
        XCTAssertEqual(dailyFeedCountBefore + 1, dailyFeedCountAfter)
    }

    func test_UpdateDailyFeed_isSuccessful() {
        dailyFeed.lunch = true
        dailyFeedsViewModel.updateDailyFeed(dailyFeed)
        XCTAssert(dailyFeed.lunch == true)
    }

    func test_DeleteDailyFeed_decreasesDailyFeedCount() {
        let dailyFeedCountBefore = dailyFeedsViewModel.dailyFeeds.count
        // swiftlint:disable:next force_unwrapping
        dailyFeedsViewModel.deleteDailyFeed(UUID(uuidString: "BF1B9558-50FF-4229-8892-732164120B42")!)
        let dailyFeedCountAfter = dailyFeedsViewModel.dailyFeeds.count
        XCTAssertEqual(dailyFeedCountBefore - 1, dailyFeedCountAfter)
    }

    func test_DailyFeedsViewModel_loadsFeeds() {
        XCTAssertFalse(dailyFeedsViewModel.feeds.isEmpty, "DailyFeedsViewModel should load the mock feeds")
        XCTAssertNotNil(feed.id, "feed.id should not be nil")
        // swiftlint:disable:next force_unwrapping
        XCTAssertEqual(feed.petID, UUID(uuidString: "08F40734-EFE6-4D75-B59A-37CD55948DBE")!)
    }

    func test_DailyFeedsViewModel_savesFeeds() {
        XCTAssertNoThrow(dailyFeedsViewModel.saveFeeds())
    }

    func test_DeleteFeed_deletesFeed() {
        let feedCountBefore = dailyFeedsViewModel.feeds.count
        // swiftlint:disable:next force_unwrapping
        dailyFeedsViewModel.deleteFeed(UUID(uuidString: "E16FB84E-3A4A-4108-8621-9D6F7E6BDBF0")!)
        let feedCountAfter = dailyFeedsViewModel.feeds.count
        XCTAssertEqual(feedCountBefore - 1, feedCountAfter)
    }

    func test_AddFeed_increasesFeedCount() {
        let feedCountBefore = dailyFeedsViewModel.feeds.count
        let newFeed = createFeed()
        dailyFeedsViewModel.addFeed(newFeed)
        let feedCountAfter = dailyFeedsViewModel.feeds.count
        XCTAssertEqual(feedCountBefore + 1, feedCountAfter)
    }

    func test_UpdateFeed_isSuccessful() {
        feed.feedTimes.lunch = true
        dailyFeedsViewModel.updateFeed(feed)
        XCTAssert(feed.feedTimes.lunch == true)
    }

    func createDailyFeed() -> DailyFeed {
        DailyFeed(
            date: Date(),
            // swiftlint:disable:next force_unwrapping
            feedID: UUID(uuidString: "E16FB84E-3A4A-4108-8621-9D6F7E6BDBF0")!
        )
    }

    func createFeed() -> Feed {
        Feed(
            id: UUID(),
            feedTimes: FeedTimes(morning: true, lunch: false, evening: true),
            // swiftlint:disable:next force_unwrapping
            petID: UUID(uuidString: "08F40734-EFE6-4D75-B59A-37CD55948DBE")!,
            isFed: false
        )
    }
}
