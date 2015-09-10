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

class ProgressBarModelTests: XCTestCase {
    
    var progressBarModel: ProgressBarModel?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        progressBarModel = ProgressBarModel(bar: NSProgressIndicator())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatBarMaxIsSet() {
        XCTAssert(progressBarModel!.getBarMax() == 30,
            "Check that bar max is initialised at 30.")
        progressBarModel!.setBarMax(90)
        XCTAssert(progressBarModel!.getBarMax() == 90,
            "Check that bar max was set correctly.")
    }
}

