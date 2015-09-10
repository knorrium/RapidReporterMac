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

class ContextualMenuModel {
    
    /**
    Creates the context menu to be shown when the user right clicks
    on the text field.
    
    :returns: Returns an `NSMenu` object to be displayed to the user.
    */
    func createTextFieldContextMenu(notes: [String]) -> NSMenu {
        let menu = NSMenu()
        for note in notes {
            menu.addItem(NSMenuItem(title: note, action: Selector("noteSelector:"), keyEquivalent: ""))
        }
        return menu
    }
    
    /**
    Creates the context menu shown when the user right clicks on the window.
    This menu contains '**Session Length**' and '**Open working folder**' options.
    
    :returns: Returns an `NSMenu` object to be displayed to the user.
    */
    func createContextMenu() -> NSMenu {
        // Show context menu on right click.
        let menu = NSMenu()
        let subMenu = NSMenu()
        menu.addItemWithTitle("Session Length", action: Selector("sessionLengthSelector:"), keyEquivalent: "")
        menu.addItemWithTitle("Open working folder", action: Selector("openFolderSelector:"), keyEquivalent: "")
        
        // Programatically add four options to session length sub menu.
        for (var i = 1; i <= 4; i++) {
            var minsEntry = NSMenuItem(title: "\(i * 30) mins from now", action: Selector("timeSelector:"), keyEquivalent: "")
            minsEntry.tag = i * 30
            subMenu.addItem(minsEntry)
        }
        subMenu.setSubmenu(subMenu, forItem: menu.itemAtIndex(0)!)
        return menu
    }
    
    /**
    Displays the supplied menu as a popup to the user.
    
    :param: menu The menu to be shown to the user.
    :param: theEvent The even that called this method.
    */
    func showContextMenu(menu: NSMenu, theEvent: NSEvent, view: NSView){
        NSMenu.popUpContextMenu(menu, withEvent: theEvent, forView: view)
    }
    
    /**
    Sets the context menu of the field editor.
    
    The field editor is the control that is used to handle all input
    to text boxes in the application and is supplied by the application.
    */
    func setFieldEditorMenu(textField: NSTextField, notes: [String]){
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        let fieldEditor: NSText = appDelegate.window!.fieldEditor(true, forObject: textField)!
        
        fieldEditor.menu = createTextFieldContextMenu(notes)
    }
}