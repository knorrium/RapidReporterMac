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

/// The class used to store information aboout RTF notes and single line notes.
class NotesModel {
    
    private var fileIO: FileIOModel?
    /// Number of RTF notes taken this session so far. Used for file naming.
    private var notesTakenThisSession: Int;
    /// The file name of the last RTF note that was saved.
    private var lastNoteName: String?
    /// The path of the last RTF note that was saved.
    private var lastNotePath: String?
    /// An array of the last six single line notes taken by the user. Used in the text field's contextual menu.
    private var previousNoteMessages = [String]()
    
    init (fileIO: FileIOModel){
        self.fileIO = fileIO;
        self.notesTakenThisSession = 0
    }
    
    /** 
        This method is used to open either a new or existing RTF note.
    
        :param: openNewNote A boolean that tells the method to open a new note or not.
        :returns: The path of the file that was just opened.
    */
    func openNote(openNewNote: Bool) -> String {
        
        let customFormatter = DateFormatterModel()
        let fileNameDate = customFormatter.getFileNameTimeStamp()
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! NSString
        let rapidReporterPath = fileIO!.getAbsolutePathOfSessionFolder()
        
        // Get new file's name.
        var fileName: String?
        var filePath: String?
        if (openNewNote){
            fileName = String(++notesTakenThisSession) + "_" + fileNameDate + ".rtf"
            filePath = rapidReporterPath + fileName!
            lastNoteName = fileName
            duplicateNote(filePath!)
        } else {
            filePath = lastNotePath
        }
        
        lastNotePath = filePath
        
        // Launch TextEdit with new file.
        let task = NSTask()
        task.launchPath = "/usr/bin/open"
        task.arguments = ["-e", filePath!]
        task.launch()
        task.waitUntilExit()
        
        return lastNoteName!
    }
    
    /** 
        Duplicates a note file to the path provided. It will either copy the RTF template from the bundle or the last note taken depending on whether or not this is the first note of the session.
    
        :param: filePath The path that the file should be copied to.
    */
    private func duplicateNote(filePath: String) {
        
        // Copy template if it doesn't exist.
        if (notesTakenThisSession == 1){
            copyTemplate(filePath)
        } else {
            copyLastNote(filePath)
        }
        
    }
    
    /** 
        Copies the RTF note template from the application bundle.
    
        :param: filePath The path to copy the template to.
    */
    private func copyTemplate(filePath: String){
        
        // Get URL of template.
        let bundleURL = NSBundle.mainBundle().URLForResource("blankRTF", withExtension: "rtf")
        
        let errorPointer: NSErrorPointer = NSErrorPointer()
        
        // Copy file.
        let fileManager = NSFileManager.defaultManager()
        fileManager.copyItemAtURL(bundleURL!, toURL: NSURL(fileURLWithPath: filePath)!, error: errorPointer)
        
    }
    
    /** 
        Copies the last note taken this session.
    
        :param: newNotePath The path that the note should be copied to.
    */
    private func copyLastNote(newNotePath: String){
        let errorPointer: NSErrorPointer = NSErrorPointer()
        
        // Copy file.
        let fileManager = NSFileManager.defaultManager()
        fileManager.copyItemAtURL(NSURL(fileURLWithPath: lastNotePath!)!, toURL: NSURL(fileURLWithPath: newNotePath)!, error: errorPointer)
    }
    
    /** 
        Gets the last six one line notes input by the user.
    
        :returns: An array of the last six notes taken by the user.
    */
    func getPreviousMessageNotes() -> [String] {
        return previousNoteMessages
    }
    
    /** 
        Saves a one line note to the array of previous one line notes.
    
        :param: messageNote The note to save.
    */
    func saveMessageNote(messageNote: String) {
        // If already six stored, removed least recent and append.
        if (previousNoteMessages.count == 6) {
            previousNoteMessages.removeAtIndex(0)
        }
        previousNoteMessages.append(messageNote)
    }
    
}
