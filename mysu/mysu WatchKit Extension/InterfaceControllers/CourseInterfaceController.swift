//
//  CourseInterfaceController.swift
//  mysu WatchKit Extension
//
//  Created by ynsclk on 27.02.2020.
//  Copyright © 2020 ynsclk. All rights reserved.
//

import WatchKit
import Foundation


class CourseInterfaceController: WKInterfaceController {
    let days = ["monday","tuesday","wednesday","thursday","friday","saturday","sunday"]
    let a = Int()
    
    @IBOutlet weak var infoLabel: WKInterfaceLabel!
    var Schedule : NSDictionary = [:]
    @IBOutlet weak var CourseTable: WKInterfaceTable!
    let d = Days()
    var dayName = ""
    var DayIndex:Int = 0
    var today : NSDictionary? = [:]
    var weekend : Bool = false
    
    @IBOutlet weak var prbtn: WKInterfaceButton!
    
    
    @IBAction func prevButton() {
        
        self.swiped_rigth((Any).self)
    }
    
    @IBAction func nextButton() {
        self.swiped_left((Any).self)
    }
    
    @IBAction func swiped_left(_ sender: Any) {
        
        dayName = d.getNextDay(day: dayName)
        DayIndex = d.getDayIndex(day: dayName)
        
        today = self.Schedule.value(forKey: self.days[DayIndex]) as? NSDictionary
        if (today == nil || ((dayName == "Saturday" || dayName == "Sunday") && self.weekend == false ) ) {
            self.NullDay()
        }
        else{
            self.loadCourse(day: today! ,ifToday: false)
        }
        Label.setText(dayName)
    }
    @IBAction func swiped_rigth(_ sender: Any) {
        dayName = d.getPrevDay(day: dayName)
        
        DayIndex = d.getDayIndex(day: dayName)
        
        today = self.Schedule.value(forKey: self.days[DayIndex]) as? NSDictionary
        if (today == nil || ((dayName == "Saturday" || dayName == "Sunday") && self.weekend == false )) {
            self.NullDay()
            
        }
        else{
            self.loadCourse(day: today! ,ifToday: false)
        }
        
        Label.setText(dayName)
        
    }
    @IBOutlet weak var Label: WKInterfaceLabel!
    
    
    override func awake(withContext context: Any?) {
        
       
        
        super.awake(withContext: context)
        self.infoLabel.setText("Loading Data...")
        dayName = d.getToday()
        DayIndex = d.getDayIndex(day: dayName)
        Label.setText(dayName)
        loadCourseData()
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    private func loadCourseData() {
      
        
        
        let url = "https://www.sabanciuniv.edu/apps/test/course_schedule.php?termcode=201901"
       // let urlObjCourse = URL(string: url)
        var urlObjCourse = URLRequest(url: URL(string:url)!)
        let d = Days()
        let date = d.getTodayDate()
        if(settingsReload.Course == date) {
            urlObjCourse.cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
            
        }
        else {
            URLCache.shared.removeCachedResponse(for: urlObjCourse)
            urlObjCourse.cachePolicy = URLRequest.CachePolicy.reloadRevalidatingCacheData
            settingsReload.Course = date

        }
        //urlObjCourse.cachePolicy = URLRequest.CachePolicy.reloadRevalidatingCacheData
        
        let dataTask = URLSession.shared.dataTask(with: urlObjCourse)  { (data,response, error) in
                do {
                    self.infoLabel.setText("")
                    if(data != nil) {
                
                
                        let arbitrary = try JSONSerialization.jsonObject(with: data!,options: .mutableContainers)
                        let dict = arbitrary as! NSDictionary
                        self.Schedule = dict
                    
                        let today = self.Schedule.value(forKey: self.days[self.DayIndex]) as? NSDictionary
                        
                        self.weekend = self.Schedule.value(forKey: "weekend") as? Bool ?? false
                        
                        if(today == nil) {
                            self.NullDay()
                        }
                        else {
                            self.loadCourse(day: today! , ifToday: true)
                        }
                }
                    else {
                        self.infoLabel.setText("Error in connection")
                        //self.loadCourse(day: nil)
                    }
                
            } catch let DecodingError.dataCorrupted(context) {
                
                print(context)
                
                //print(error?.localizedDescription)
                //print(response)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
            
            }
        dataTask.resume()
        
        
        
        
    }
    
    
    func NullDay () {
        self.CourseTable.setNumberOfRows(1, withRowType: "CourseRowController")
        let row = self.CourseTable.rowController(at: 0 ) as! CourseRowController
        row.course.setText("No Result")
        row.time.setText("")
        row.venue.setText("")
    }
    
    
    func generateRandomColor() -> UIColor {
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        
        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        return randomColor
    }
    
    func loadCourse( day : NSDictionary?, ifToday: Bool) {
        if (day == nil || day!.value(forKey: "recordcount") as! Int == 0) {
            self.CourseTable.setNumberOfRows(1, withRowType: "CourseRowController")
            let row = self.CourseTable.rowController(at: 0 ) as! CourseRowController
            row.course.setText("No Result")
            row.time.setText("")
            row.venue.setText("")
            row.endTime.setText( "" )
            row.building.setText("")
            
        }
        else {
            
            let inday = day!
            let begintime = inday.value(forKey: "begintime") as! NSArray
            let endtime = inday.value(forKey: "endtime") as! NSArray
            let building = inday.value(forKey: "buildingcode") as! NSArray
            let room = inday.value(forKey: "roomcode") as! NSArray
            let course = inday.value(forKey: "uniqueall") as! NSArray
            let count = inday.value(forKey: "recordcount") as! Int
            self.CourseTable.setNumberOfRows( count, withRowType: "CourseRowController")
            
            
            
            
            
            var index = 0
            if(ifToday) {
                let date = Date()
                let dateFormatter1 = DateFormatter()
                let dateFormatter2 = DateFormatter()
                dateFormatter1.dateFormat = "HH"
                dateFormatter2.dateFormat = "mm"
                let Dhour = dateFormatter1.string(from: date)
                let Dminute = dateFormatter2.string(from: date)
                
                
                var isSet :Bool = false
                for i in 0...count-1 {
                    let h =  begintime[i] as! String
                    let b = h.split(separator: ":")
                    
                    let hrr = Int("\(b[0])") as! Int
                    let mnn = Int("\(b[1])") as! Int
                    
                    if(    isSet == false   &&     (    hrr > Int(Dhour)!  || ( hrr == Int(Dhour)!   && mnn > Int(Dminute)! )  )  ){
                        index = i
                        isSet = true
                        
                    }
                }
            }
            
            
            
            
            
            
            
            
            
            
            
            
            for s in 0...count-1 {
                
                let row = self.CourseTable.rowController(at: s ) as! CourseRowController
               // let hour =  "\(begintime[s]) - \(endtime[s])"
                // row.time.setText(String(key) as? String)
                
                let lecture = course[s] as! String
                row.courseGroup.setBackgroundColor(generateRandomColor())
                
                let location = "\(building[s]) - \(room[s])"
                
                row.course.setText( lecture )
                row.time.setText( "\(begintime[s])" )
                row.endTime.setText( "\(endtime[s])" )
                row.building.setText("\(building[s])")
                row.venue.setText("\(room[s])")
                if(s == index && ifToday) {
                    row.time.setTextColor(UIColor(red:0.0, green:122.0/255.0 ,blue:1.0 ,alpha:1.0))
                }
                
            }
             if(ifToday) {
                self.CourseTable.scrollToRow(at: index)
                }
            
        }
    }
    
    func loadCourse2( day : NSDictionary?) {
        if (day == nil) {
            self.CourseTable.setNumberOfRows(1, withRowType: "CourseRowController")
            let row = self.CourseTable.rowController(at: 0 ) as! CourseRowController
            row.course.setText("No Result")
            row.time.setText("")
            row.venue.setText("")
            
        }
        else {
            let inday = day as! NSDictionary
        
        var i = 0
        var Day = Dictionary<Int,String> ()
        for ( key,value) in inday {
            if((value as! String) != "" ){
                i = i + 1
                Day.updateValue(inday.value(forKey : key as! String ) as! String , forKey: Int(key as! String)! )
                
            }
        }
     
        
        let sortedDay = Day.sorted ( by: { $0.0  < $1.0 } )
        var courses : [String] = []
        
        
        var  s = 0
        self.CourseTable.setNumberOfRows(sortedDay.count , withRowType: "CourseRowController")
        let prevcourse = ""
        for(key,value) in sortedDay {
            
            let row = self.CourseTable.rowController(at: s ) as! CourseRowController
            let hour =  String(key/100) + ":" + String(key).suffix(2)
           // row.time.setText(String(key) as? String)
            row.time.setText(hour)
            let lecture = value as! String
            
            
            var firstSpace = lecture.firstIndex(of: "-") ?? lecture.endIndex
            let name = lecture.prefix(upTo: firstSpace)
            
            let venue = lecture.suffix(from: firstSpace) 
            
            row.course.setText("\(name)" )
            row.venue.setText("\(venue)")
            s = s + 1
            }
        }
    }


}
