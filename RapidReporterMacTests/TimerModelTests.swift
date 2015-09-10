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
import Cocoa
import XCTest

class TimerModelTests: XCTestCase {
    
    var timerModel: TimerModel?
    
    override func setUp() {
        super.setUp()
        timerModel = TimerModel()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTimerControl() {
        timerModel?.controlTimer("Setup")
        NSThread.sleepForTimeInterval(0.1)
        timerModel?.controlTimer("Bug")
        NSThread.sleepForTimeInterval(0.1)
        timerModel?.controlTimer("Test")
        NSThread.sleepForTimeInterval(0.1)
        timerModel?.controlTimer("Stop")
        
        XCTAssert(timerModel!.getTimes(.Setup) > 0, "Checking setup time is positive.")
        XCTAssert(timerModel!.getTimes(.Bug) > 0, "Checking bug time is positive.")
        XCTAssert(timerModel!.getTimes(.Test) > 0, "Checking test time is positive.")
    }
    
}