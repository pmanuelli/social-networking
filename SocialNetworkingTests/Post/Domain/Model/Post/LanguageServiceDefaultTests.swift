
@testable import SocialNetworking

import XCTest

class LanguageServiceDefaultTests: XCTestCase {

    private let service = LanguageServiceDefault()
    
    func testInformWhenTextContainsInapropriateLanguage() {
        
        let words = ["Android", "I like Android", "AndRoID", "Google rules!"]
        
        for word in words {
            XCTAssertTrue(service.isInappropriate(word))
        }
    }
    
    func testInformWhenTextIsAppropriate() {
        
        XCTAssertFalse(service.isInappropriate("This text is OK"))
    }
}
