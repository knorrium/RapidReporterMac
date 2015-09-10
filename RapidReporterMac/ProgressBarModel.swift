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

/** 
    Class used to control the progress bar displayed on the main screen.
*/
class ProgressBarModel {
    
    /// The seconds to wait between updates of the progress bar.
    private let secsPerUpdate: Double = 1.0
    /// The length of the testing session in minutes.
    private let sessionLengthInMins = 30
    /// Constant used to calculate the max value of the progress bar.
    private let noOfSecsInAMin = 60
    /// The actual progress bar object that is controlled.
    private var bar: NSProgressIndicator
    
    init (bar: NSProgressIndicator){
        self.bar = bar
        self.bar.maxValue = Double(sessionLengthInMins * noOfSecsInAMin)
    }
    
    /// Starts a background process that periodically updates the progress bar's value.
    func startProgressBar() {
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            var secondsElapsed =  0.0
            while (true){
                self.bar.doubleValue = Double(secondsElapsed)
                secondsElapsed = secondsElapsed + self.secsPerUpdate
                NSThread.sleepForTimeInterval(self.secsPerUpdate)
            }
        })
    }
    
    /** 
        Gets the maximum value of the progress bar.
    
        :returns: The maximum value of the progress bar as a `Double` in **minutes**.
    */
    func getBarMax() -> Double {
        return bar.maxValue / 60
    }
    
    /** 
        Set the maximum value of the progress bar.
    
        :param: maxInMins Takes an integer representation of the maximum in **minutes**.
    */
    func setBarMax(maxInMins: Int) {
        bar.maxValue = Double(maxInMins * noOfSecsInAMin)
    }
    
}
