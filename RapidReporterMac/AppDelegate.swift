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

import Cocoa
import Foundation

@NSApplicationMain
public class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    @IBOutlet weak var window: NSWindow!
    var masterViewController: ViewController!
    let windowWidth = 700
    let windowHeight = 82
    let menuHeight = 22

    public func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        // Insert code here to initialize your application
        // Checks for command line arguments.
        var args: [String]?
        for arg in Process.arguments {
            if ((arg.rangeOfString("-NS") == nil) && (arg.rangeOfString("YES") == nil) && (arg.rangeOfString("/")) == nil && (arg.rangeOfString("-psn_") == nil)) {
                if (args == nil) {
                    args = []
                }
                args?.append(arg)
            }
        }
        
        // Set the view that the view controller manages.
        masterViewController = ViewController(nibName: "View", bundle: nil)
        // If command line arguments were provided then set the categories to the args.
        if (args != nil) {
            masterViewController.sessionModel!.setCategories(args!)
        }
        
        // Setting the window's properties.
        window.delegate = self
        window.setContentSize(NSSize(width: windowWidth, height: windowHeight))
        window.minSize = NSSize(width: windowWidth, height: windowHeight + menuHeight)
        window.maxSize = NSSize(width: 1920, height: windowHeight + menuHeight)
        window.contentView.addSubview(masterViewController.view)
        window.level = Int(CGWindowLevelForKey(Int32(kCGScreenSaverWindowLevelKey)))
        window.backgroundColor = NSColor(red: 0.96, green: 0.86, blue: 0.0, alpha: 1.0)
        window.center()
        
        // Sets view constraints.
        masterViewController.view.frame = (window.contentView as! NSView).bounds
        masterViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: ["subView" : masterViewController.view])
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: ["subView" : masterViewController.view])
        
        NSLayoutConstraint.activateConstraints(verticalConstraints + horizontalConstraints)
    }
    
    public func applicationShouldTerminate(sender: NSApplication) -> NSApplicationTerminateReply {
        masterViewController.finalise()
        return NSApplicationTerminateReply.TerminateNow
    }
    
    public func windowShouldClose(sender: AnyObject) -> Bool {
        masterViewController.finalise()
        exit(0)
    }

    public func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    // Helper functions
    func setWindowTransparency(value: Int){
        // Divide by 100 to get a value between 0 and 1.
        window.alphaValue = CGFloat(Double(value) / 100.0)
    }

}

