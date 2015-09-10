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

class TimerModel {
    
    /** 
        Categories enum is used to indicate which category is currently selected.
            
        - Setup
        - Bug
        - Test
    
    */
    enum Categories {
        case Setup, Bug, Test
    }
    
    private var categoryEnum: Categories?
    private var setupTime, bugTime, testTime, timeTaken: Double?
    /// Used to calculate the time spent on each category.
    var startTime, endTime: NSDate?
    
    init(){
        setupTime = 0
        bugTime = 0
        testTime = 0
        timeTaken = 0
    }
    
    func getTimes(category: Categories) -> Double? {
        switch category {
        case .Setup:
            return setupTime!
        case .Test:
            return testTime!
        case .Bug:
            return bugTime!
        default:
            return nil
        }
    }
    
    /**
        Controls the session category timer depending on the current category.
    
        :param: currentCategory The current note category.
    */
    func controlTimer(currentCategory: String){
        switch currentCategory {
        case "Setup":
            stopTimer()
            startTimer(.Setup)
            break
        case "Bug":
            stopTimer()
            startTimer(.Bug)
            break
        case "Test":
            stopTimer()
            startTimer(.Test)
            break
        default:
            stopTimer()
            break
        }
    }
    
    /// Stops the current timer, adds the time to the correct category, and resets the timer.
    func stopTimer(){
        if (startTime == nil && endTime == nil) {
            return
        }
        endTime = NSDate()
        timeTaken = endTime!.timeIntervalSinceDate(startTime!)
        switch categoryEnum! {
        case .Setup:
            setupTime! += timeTaken!
            break
        case .Bug:
            bugTime! += timeTaken!
            break
        case .Test:
            testTime! += timeTaken!
            break
        default:
            break
        }
        startTime = nil
        endTime = nil
    }
    
    /** 
        Start the timer.
    
        :param: categoryEnum The current category that this timer's end result should be added to.
    */
    func startTimer(categoryEnum: Categories){
        self.categoryEnum = categoryEnum
        self.startTime = NSDate()
    }
    
    /** 
        Calculate the ratios of time spent in each of the three categories with respect to the total time spent in the three categories.
    
        :param: categoryEnum The category to get the percentage ratio for.
        :returns: The ration of total time spent in the given category as a string with a percent sign prepended.
    */
    func calculateRatios(categoryEnum: Categories) -> String {
        
        let total = setupTime! + bugTime! + testTime!
        
        switch categoryEnum {
        case .Setup:
            var setupPercent: Double = (setupTime! / total) * 100
            var setupPercentAsString: String = String(format:"%.1f", setupPercent)
            return setupPercentAsString + "%"
        case .Test:
            var testPercent: Double = (testTime! / total) * 100
            var testPercentAsString: String = String(format:"%.1f", testPercent)
            return testPercentAsString + "%"
        case .Bug:
            var bugPercent: Double = (bugTime! / total) * 100
            var bugPercentAsString: String = String(format:"%.1f", bugPercent)
            return bugPercentAsString + "%"
        default:
            return ""        }
    }
    
}