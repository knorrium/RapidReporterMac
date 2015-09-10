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

class SessionModel {
    
    private var reporterName: String?
    private var charter: String?
    private var currentCategory: String?
    private var categories = ["Setup", "Note", "Test", "Check", "Bug", "Question", "Next Time"]
    private var categoryIndex: Int = 0
    private var isCustomCategories = false
    
    /// Used to calculate the duration of the session.
    private var sessionStart: NSDate?
    
    func getReporterName() -> String? {
        return reporterName
    }
    
    func setReporterName(value: String) {
        reporterName = value
    }
    
    func getCharter() -> String? {
        return charter
    }
    
    func setCharter(value: String){
        charter = value
    }
    
    func getCurrentCategory() -> String? {
        return currentCategory
    }
    
    func setCurrentCategory(value: String){
        currentCategory = value
    }
    
    func getCategories() -> [String] {
        return categories
    }
    
    func setCategories(value: [String]){
        isCustomCategories = true
        categories = value
    }
    
    /// Saves the current time as the sessionStart. Used for calculating session duration.
    func startSession() {
        sessionStart = NSDate()
    }
    
    /**
        Ends the testing session.
    
        :returns: A string representation of the duration of the session in the format **HH:mm:ss**
    */
    func endSession() -> String {
        var formatter = DateFormatterModel()
        return formatter.formatTimeInterval(NSDate().timeIntervalSinceDate(sessionStart!))
    }
    
    func getCategoryIndex() -> Int {
        return categoryIndex
    }
    
    func setCategoryIndex(value: Int) {
        return categoryIndex = value
    }
    
    func getIsCustomCategories() -> Bool {
        return isCustomCategories
    }
    
}