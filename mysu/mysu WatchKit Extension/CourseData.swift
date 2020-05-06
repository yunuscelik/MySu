//
//  CourseData.swift
//  mysu WatchKit Extension
//
//  Created by ynsclk on 2.04.2020.
//  Copyright © 2020 ynsclk. All rights reserved.
//

import WatchKit

class CourseData {
    var day: NSDictionary?
    func load(key: String) {
        
        
        let url = "https://www.sabanciuniv.edu/apps/test/course_schedule.php?termcode=201901"
        // let urlObjCourse = URL(string: url)
        var urlObjCourse = URLRequest(url: URL(string:url)!)
        urlObjCourse.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        let dataTask = URLSession.shared.dataTask(with: urlObjCourse)  { (data,response, error) in
            do {
                
                
                
                let arbitrary = try JSONSerialization.jsonObject(with: data!,options: .mutableContainers)
                let dict = arbitrary as! NSDictionary
                
                let monday = dict.value(forKey: key) as! NSDictionary
                self.day = monday
                /*
                 var i = 0
                 var Day = Dictionary<String,String> ()
                 for ( key,value) in monday {
                 if((value as! String) != "" ){
                 i = i + 1
                 Day.updateValue(monday.value(forKey : key as! String ) as! String , forKey: key as! String)
                 // Day [ key ] = monday.value(forKey : key )
                 
                 
                 }
                 }
                 
                 // let a = Day.sorted(by: { $0.0 < $1.0 }) as! Dictionary<String,String>
                 let objects = Day.sorted{ $0.0 < $1.0 }.map{ $0}
                 print (objects)
                 // Day = Day.sorted{ $0.0 < $1.0 }
                 // self.CourseTable.setNumberOfRows(Day.count , withRowType: "CourseRowController")
                 
                 //print(monday.value(forKey :"1040"))
                 // let objects = dict.sorted{ $0.0 < $1.0 }.map{ $1 }
                 
                 
                 /*
                 for (index, value) in Day.enumerated() {
                 let row = self.CourseTable.rowController(at: index ) as! CourseRowController
                 row.time.setText(value as! String)
                 }
                 
                 
                 
                 
                 var s = 0
                 for ( key,value) in monday {
                 if((value as! String) != "" ){
                 var row = self.CourseTable.rowController(at: (s + 1) ) as! CourseRowController
                 row.time.setText(key as! String)
                 s = s + 1
                 }
                 }
                 */
                 /*
                 if ( monday.object(forKey: key) as? String != "") {
                 print(monday.object(forKey: key) as? String)
                 //     let row = self.CourseTable.rowController(at: key as! Int) as! CourseRowController
                 //   row.time.setText(String(key))
                 // row.course.setText(String((key,value)))
                 //print(key,":",value)
                 
                 }
                 
                 */
                 */
                
                
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
}
