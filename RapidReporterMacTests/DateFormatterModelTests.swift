/*

Copyright 2015 Skyscanner Ltd

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
file except in compliance with the License. You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under
the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
ANY KIND, either express or implied. See the License for the specificlanguage governing
permissions and limitations under the License.

*/

import Foundation
import XCTest

class DateFormatterModelTests: XCTestCase {
    
    var formatter: DateFormatterModel?
    
    override func setUp() {
        super.setUp()
        formatter = DateFormatterModel()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTimeIntervalCalculation() {
        
        // Create two NSDates
        let date1 = NSDate()
        let date2 = NSDate(timeInterval: NSTimeInterval(9147.67), sinceDate: date1)
        
        // Call the format time interval method.
        let formatted = formatter!.formatTimeInterval(date2.timeIntervalSinceDate(date1))
        
        // Assert result is correct.
        XCTAssert(formatted == "02:32:28", "Checking time interval formatting method.")
        
    }
    
    func testPadWithZero(){
        XCTAssert(formatter!.padWithZero(0) == "00", "Testing padding with zero.")
        XCTAssert(formatter!.padWithZero(7) == "07", "Testing padding with seven.")
        XCTAssert(formatter!.padWithZero(29) == "29", "Testing padding 29.")
    }
}