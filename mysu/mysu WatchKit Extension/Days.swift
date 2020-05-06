//
//  Days.swift
//  mysu WatchKit Extension
//
//  Created by ynsclk on 2.04.2020.
//  Copyright © 2020 ynsclk. All rights reserved.
//

import WatchKit

class Days: NSObject {
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var i = 0
    public func getToday() -> String {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
        
    }
    public func getTodayDate() -> String {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateinfo = dateFormatter.string(from: date)
        return dateinfo
        
    }
    
    
    
    public func getDayIndex (day:String)-> Int {
        var rt = day
        var index = 0
        for i in 0...7 {
            
            if (days[i] == rt ) {
                index = i
                break
                }
        }
        return index
    }
    
    
    public func getNextDay(day:String)-> String {
        var rt = day
        for i in 0...7 {
            
            if (days[i] == rt ) {
                rt = days[(i+1)%7]
                break
            }
            
        }
        return rt
    }
    public func getPrevDay (day:String)-> String{
        var rt = day
        for i in 0...7 {
            
            if (days[i] == rt ) {
                if(i==0){
                    rt = days[6]
                    break
                }
                else{
                rt = days[(i-1)%6]
                    break
                }
            }
            
        }
        return rt
    }
    
}
