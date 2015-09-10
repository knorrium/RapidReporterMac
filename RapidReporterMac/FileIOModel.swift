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

class FileIOModel {
    
    private var logFilePath: String?
    private var sessionFolderName = "/RapidReporterMac Output/"
    private var reporterName: String?
    
    private let documentsPath: NSString?
    private let csvColumns = "Time,Reporter,Type,Content,Screenshot,RTF Note"
    private let testVersionNumber = "0.1"
    
    // Constructor
    init (reporterName: String) {
        self.reporterName = reporterName
        documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as? NSString
        checkDocumentsFolderExists(documentsPath)
    }
    
    // Attribute Access
    
    /** 
        Gets the absolute path of the session folder.
    
        :return: A string representation of the absolute path of the session folder.
    */
    func getAbsolutePathOfSessionFolder() -> String {
        return documentsPath!.stringByAppendingString(sessionFolderName)
    }
    
    // Logic
    
    /**
        Checks for the existence of the documents folder. Raises an alert if not, and will close the program whent the user clicks OK.
    
        :param: path The path to the documents folder.
    */
    func checkDocumentsFolderExists(path: NSString?){
        if (path == nil) {
            var alert = NSAlert()
            alert.messageText = "'Documents' folder does not exist."
            alert.alertStyle = NSAlertStyle.CriticalAlertStyle
            alert.informativeText = "Please create a 'Documents' folder in your user directory and restart the application."
            alert.runModal()
            exit(0)
        }
    }
    
    /** 
        Replaces any characters in the user input that could break the CSV file format used for the logs.
    
        :param: userInput The user input string to remove potentially dangerous characters from.
        :returns: The user's input with any dangerous characters replaced with suitable substitutes.
    */
    func sanitiseUserInput(userInput: String) -> String {
        // Iterates over each char in the input and replaces , or ".
        let sanitisedInput = String(map(userInput.generate()) {
            switch $0 {
                case ",":
                    return ";"
                case "\"":
                    return "'"
                default:
                    return $0
            }
        })
        return sanitisedInput
    }
    
    /** 
        Creates a new entry in the current session's log file using the supplied information.
    
        :param: currentCategory The current category of note the user has selected e.g. Setup, Test, Bug, etc.
        :param: textToWrite The text that the user has input.
        :param: screenshotPath The path to the most recently taken screenshot file.
        :param: rtfNotePath The path to the most recently saved RTF note.
    */
    func logToFile(currentCategory: String, textToWrite: String, screenshotPath: String?, rtfNotePath: String?) {
                                
        var cleanUserInput = sanitiseUserInput(textToWrite)
                                
        // Construct the information that will be logged.
        var formatter = DateFormatterModel()
        var infoToLog = formatter.getFormattedTimestamp() + ","
        infoToLog = infoToLog + reporterName! + ","
        infoToLog = infoToLog + currentCategory + ","
        infoToLog = infoToLog + addQuotationMarks(cleanUserInput) + ","
        // Check optional additions for nils before writing.
        if screenshotPath != nil {
            infoToLog = infoToLog + screenshotPath! + ","
        } else {
            infoToLog = infoToLog + ","
        }
        if rtfNotePath != nil {
            infoToLog = infoToLog + rtfNotePath!
        }
        File.appendToFile(logFilePath!, content: infoToLog)
    }
    
    /** 
        Creates a new folder for the program to save to.
    
        :param: formattedDate The formatted date to be used as the folder's name.
        :returns: A boolean value representing whether or not the folder was successfully created.
    */
    func createFolder(formattedDate: String) -> Bool {
        sessionFolderName += (formattedDate + "/")
        let folderUrl = String(documentsPath!) + sessionFolderName
        var err: NSErrorPointer = nil
        return NSFileManager().createDirectoryAtPath(folderUrl, withIntermediateDirectories: true, attributes: nil, error: err)
    }
    
    /** 
        Creates a new file in the current session's folder with the necessary CSV headers.
    
        :param: fileName The name of the file to be created.
        :param: header The CSV column headers to be written to the file upon creation.
    */
    private func createFileWithCSVHeader(logFilePath: String, header: String){
        File.write(self.logFilePath!, content: header, encoding: NSUTF8StringEncoding)
    }
    
    /** 
        Initialises a new log file for this session by creating a log file and writing the CSV column headers, the version of the program, the reporter's name, and the session's charter.
    
        :param: charter The new session's charter.
    */
    func initialiseLog(charter: String){
        logFilePath = documentsPath?.stringByAppendingString(sessionFolderName + makeLogFileName())
        createFileWithCSVHeader(logFilePath!, header: csvColumns)
        logToFile("(Rapid Reporter version)", textToWrite: testVersionNumber, screenshotPath: nil, rtfNotePath: nil)
        logToFile("Session Reporter", textToWrite: reporterName!, screenshotPath: nil, rtfNotePath: nil)
        logToFile("Session Charter", textToWrite: charter, screenshotPath: nil, rtfNotePath: nil)
    }
    
    /** 
        Closes the log file and writes out the session's duration.
    */
    func closeLog(duration: String){
        logToFile("Session End. Duration", textToWrite: duration, screenshotPath: nil, rtfNotePath: nil)
    }
    
    /** 
        Adds quotation marks to a given string.
    
        :param: text The string to add quotation marks to.
        :returns: The string with quotation marks added to it.
    */
    func addQuotationMarks(text: String) -> String {
        return "\"" + text + "\""
    }
    
    /** 
        Makes a file name that is used as the name for a screenshot file.
    
        :param: noOfScreenshotsThisSession The number of screenshots taken during this session so far. This is prepended to the file name.
        :returns: The screenshot file name.
    */
    func makeScreenshotFileName(noOfScreenshotsThisSession: Int) -> String {
        var formatter = DateFormatterModel()
        return String(noOfScreenshotsThisSession) + "_" + formatter.getFileNameTimeStamp() + ".png"
    }
    
    /**
        Makes a file name that is used as the name for a log file.
    
        :returns: A file name with a `.csv` file extension.
    */
    func makeLogFileName() -> String {
        var formatter = DateFormatterModel()
        return formatter.getFileNameTimeStamp() + ".csv"
    }
    
}
