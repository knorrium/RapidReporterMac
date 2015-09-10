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

class FileIOTests: XCTestCase {
    
    var fileIOModel: FileIOModel?
    var fileName: String?
    
    override func setUp() {
        super.setUp()
        fileIOModel = FileIOModel(reporterName: "Reporter's Name")
        fileName = "testFile"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSanitiseUserInput(){
        let userInput = "\"\"\",,,"
        let sanitisedUserInput = fileIOModel!.sanitiseUserInput(userInput)
        
        XCTAssert(sanitisedUserInput == "''';;;", "Checking sanitisation of user input.")
    }
    
    func testFolderCreation() {
        fileIOModel!.createFolder("testFolder")
        var filePath = fileIOModel!.getAbsolutePathOfSessionFolder()
    
        XCTAssert(File.exists(filePath))
    }
    
    func testAddingQuotationMarks() {
        let testText = "testing"
        let testTextWithQuotes = fileIOModel!.addQuotationMarks(testText)
        
        XCTAssert(testTextWithQuotes == "\"" + testText + "\"", "Testing that adding quotes to strings works.")
    }
}