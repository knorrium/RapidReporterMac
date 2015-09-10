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

class NotesModelTests: XCTestCase {
    
    var notesModel: NotesModel?
    var fileIOModel: FileIOModel?
    
    override func setUp() {
        super.setUp()
        fileIOModel = FileIOModel(reporterName: "Reporter's Name")
        notesModel = NotesModel(fileIO: fileIOModel!)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatNoteIsCreated() {
        var noteName = notesModel?.openNote(true)
        XCTAssert(File.exists(fileIOModel!.getAbsolutePathOfSessionFolder() + noteName!), "Checking that note creation works.")
    }
    
    func testThatPreviousNotesWork() {
        var testMessage = "This is a test."
        notesModel!.saveMessageNote(testMessage)
        XCTAssert(notesModel!.getPreviousMessageNotes().count != 0, "Checking previous messages has a value.")
        XCTAssert(notesModel!.getPreviousMessageNotes()[0] == testMessage, "Checking value was set correctly.")
    }
    
}
