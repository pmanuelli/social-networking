
@testable import SocialNetworking

import XCTest

class PostTimeDescriptionTest: XCTestCase {

    func testPostTimeDescription() {
        
        let now = Date(timeIntervalSinceNow: 0)
        let thirtySecondsAgo = Date(timeInterval: -30, since: now)
        let tenMinutesAgo = Date(timeInterval: -10 * 60, since: now)
        let twoHoursAgo = Date(timeInterval: -60 * 60 * 2, since: now)
        let threeDaysAgo = Date(timeInterval: -60 * 60 * 24 * 3, since: now)
                
        XCTAssertEqual(PostTimeDescription.description(for: thirtySecondsAgo, since: now), "30s")
        XCTAssertEqual(PostTimeDescription.description(for: tenMinutesAgo, since: now), "10m")
        XCTAssertEqual(PostTimeDescription.description(for: twoHoursAgo, since: now), "2h")
        XCTAssertEqual(PostTimeDescription.description(for: threeDaysAgo, since: now), "3d")
    }
}
