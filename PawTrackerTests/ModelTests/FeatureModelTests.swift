//
//  FeatureModelTests.swift
//  PawTrackerTests
//
//  Created by Simon Topliss on 24/03/2023.
//

@testable import PawTracker
import XCTest

final class FeatureModelTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_Features_successfullyLoadsFromBundle() {
        let allFeatures: [Feature] = Bundle.main.decode(Constants.JSONFiles.features)
        XCTAssertFalse(allFeatures.isEmpty)
        XCTAssertEqual(allFeatures.count, 4)

        let feature = allFeatures[0]
        XCTAssertEqual(feature.id, UUID(uuidString: "F528772D-AD38-43C7-8CA7-CE8FE0ABE4DA"))
        XCTAssertEqual(feature.title, "Details")
        XCTAssertEqual(feature.description, "Name, date of birth, gender, breed.")
    }

}
