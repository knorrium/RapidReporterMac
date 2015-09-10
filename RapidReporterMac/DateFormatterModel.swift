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

/// A date formatter class with custom functionality.
class DateFormatterModel {
    
    var formatter: NSDateFormatter
    
    init (){
        formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
    }
    
    /** 
        This constructor is used to initialise the formatter with a custom format.
    
        :param: format The format to use e.g. **dd/MM/yyyy HH:mm:ss**
    */
    init (format: String){
        formatter = NSDateFormatter()
        formatter.dateFormat = format
    }
    
    /** 
        Gets the date and time when this function was called and returns it as a formatted string.
    
        :returns: The current date and time in the format **dd/MM/yyyy HH:mm:ss**
    */
    func getFormattedTimestamp() -> String {
        return formatter.stringFromDate(NSDate())
    }
    
    /** 
        Gets the date and time of when this function was called and returns it as a formatted string used in the naming of files and folders.
    
        :returns: The current date and time in the format **yyyyMMdd_HHmmss**
    */
    func getFileNameTimeStamp() -> String {
        formatter.dateFormat = "yyyyMMdd_HHmmss"
        return formatter.stringFromDate(NSDate())
    }
    
    /**  
        Formats a time interval in **seconds** into a time stamp comprised of hours, minutes, and seconds. This method is used to get the duration displayed at the end of each log.
    
        :param: timeInterval An `NSTimeInterval` to convert.
        :returns: A string representation of the time interval in the format **HH:mm:ss**
    */
    func formatTimeInterval(timeInterval: NSTimeInterval) -> String {
        
        var seconds = Int(round(timeInterval))
        var minutes = Int(floor(Double(seconds) / 60))
        var hours = Int(floor(Double(minutes) / 60))
        
        minutes = Int(minutes % 60)
        seconds = Int(seconds % 60)
        
        var time: String?
        
        time = padWithZero(hours) + ":"
        time! += padWithZero(minutes) + ":"
        time! += padWithZero(seconds)
        
        return time!
    }
    
    /** 
        Adds a leading zero to any single digit integer values to make it two digits. If the integer already has two digits, it returns it as a string.
    
        :param: intToPad The integer value to pad with a zero.
        :returns: A string representation of the argument padded with a zero if necessary.
    */
    func padWithZero(intToPad: Int) -> String {
        if (intToPad < 10) {
            return "0" + String(stringInterpolationSegment: intToPad)
        } else {
            return String(stringInterpolationSegment: intToPad)
        }
    }
}
