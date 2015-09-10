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
import RapidReporterMac

class ContextualMenuModelTests: XCTestCase {
    
    var contextualMenuModel: ContextualMenuModel?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        contextualMenuModel = ContextualMenuModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatTextFieldContextMenuIsCorrect(){
        var menu: NSMenu = contextualMenuModel!.createTextFieldContextMenu(["This", "is", "a", "test"])
        
        XCTAssert(menu.numberOfItems == 4, "Checking number of menu items in context menu.")
        XCTAssert(menu.itemAtIndex(2)?.title == "a", "Check that menu items are set properly.")
    }
    
    // Currently can't test anything that uses app delegate using to casting problem.
    func DISABLED_testThatTextFieldMenuIsCorrect(){
        var textField = NSTextField()
        
        var menu: NSMenu = contextualMenuModel!.createTextFieldContextMenu(["This", "is", "a", "test"])
        contextualMenuModel!.setFieldEditorMenu(textField, notes: ["This", "is", "a", "test"])
        
        XCTAssert(textField.menu == menu, "Checking number of menu items in context menu.")
    }
}

