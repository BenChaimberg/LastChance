//
//  LastChanceTests.swift
//  LastChanceTests
//
//  Created by Ben Chaimberg on 2/5/16.
//  Copyright © 2016 Ben Chaimberg. All rights reserved.
//

import UIKit
import XCTest
@testable import LastChance

class LastChanceTests: XCTestCase {
    
    // MARK: FoodTracker Tests
    // Tests to confirm that the Meal initializer returns when no name or a negative rating is provided.
    func testMealInitialization() {
        // Success case.
        let potentialItem = Meal(name: "Newest meal", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        // Failure cases.
        let noName = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        let badRating = Meal(name: "Really bad rating", photo: nil, rating: -1)
        XCTAssertNil(badRating, "Negative ratings are invalid, be positive")
    }
    
}
