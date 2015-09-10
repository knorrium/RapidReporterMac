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

class ScreenshotModel {
    
    /// Number of screenshots taken in the current testing session so far.
    private var screensTakenThisSession: Int = 0
    
    /** 
        Takes a screenshot of the screen that the application is currently running on and saves it at `pathToSaveAt`.
    
        :param: pathToSaveAt The path to save the screenshot to.
        :param: window The current window of the program.
        :returns: A boolean indicating whether or not the file was saved.
    */
    func takeScreenshotOfActiveScreen(pathToSaveAt: String, window: NSWindow) -> Bool {
        
        var currentScreen = window.screen
        var screenDetails: NSDictionary = currentScreen!.deviceDescription
        var screenID: AnyObject? = screenDetails.objectForKey("NSScreenNumber")
        var screenIDInt: Int = screenID as! Int
        var screenIDUint32: UInt32 = UInt32(screenIDInt)
        
        var imageRef = CGDisplayCreateImage(CGDirectDisplayID(screenIDUint32)).takeUnretainedValue()
        var bitmapRepresentation = NSBitmapImageRep(CGImage: imageRef)
        var fileType: NSBitmapImageFileType = .NSPNGFileType
        var temp: [NSObject: AnyObject] = [NSObject: AnyObject]()
        
        // Convert bitmap to data
        let data: NSData? = bitmapRepresentation.representationUsingType(fileType, properties: temp) as NSData?
        
        // Save data to selected file
        data!.writeToFile(pathToSaveAt, atomically: false)
        
        return NSFileManager().fileExistsAtPath(pathToSaveAt)
    }
    
    /** 
        Launches OS X's screencapture utility to allow a user to take a screenshot of a window or select an area.
    
        :param: pathToSaveAt The path to save the screenshot to.
        :returns: A boolean indicating whether or not the file was saved.
    */
    func takeScreenshotOfSelection(pathToSaveAt: String) -> Bool {
        
        let task = NSTask()
        task.launchPath = "/usr/sbin/screencapture"
        task.arguments = ["-iW", pathToSaveAt]
        task.launch()
        task.waitUntilExit()
        
        return NSFileManager().fileExistsAtPath(pathToSaveAt)
    }
    
    /** 
        Get the number of screenshots taken so far in this session.
    
        :returns: The number of screenshots taken in the current session so far.
    */
    func getNumberOfScreenshotsTaken() -> Int {
        return screensTakenThisSession
    }
    
    /** 
        Increment the number of screenshots taken this session by one.
    */
    func incrementScreensTakenThisSession() {
        screensTakenThisSession++
    }
}
