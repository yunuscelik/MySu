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
    @IBOutlet weak var CourseTable: WKInterfaceTable!
    
    @IBOutlet weak var Label: WKInterfaceLabel!
    
    @IBAction func nextday(_ sender: Any) {
        Label.setText("Tuesday")
    }
   
    override func awake(withContext context: Any?) {
        
        super.awake(withContext: context)
        Label.setText("Monday")
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
        print("meraha")
        
        let url = "https://www.sabanciuniv.edu/apps/test/course_schedule.php?termcode=201901"
        let urlObjCourse = URL(string: url)
        
        URLSession.shared.dataTask(with: urlObjCourse!)  { (data,response, error) in
            do {
                
                
                
                let arbitrary = try JSONSerialization.jsonObject(with: data!,options: .mutableContainers)
                let dict = arbitrary as! NSDictionary
                
                let monday = dict.value(forKey: "mon") as! NSDictionary
                self.CourseTable.setNumberOfRows(monday.count, withRowType: "CourseRowController")
                
                //print(monday.value(forKey :"1040"))
                // let objects = dict.sorted{ $0.0 < $1.0 }.map{ $1 }
                for ( key,value) in monday.enumerated() {
                    
                    
                    if ( !(value as! String).isEmpty ) {
                        print(key,value)
                        let row = self.CourseTable.rowController(at: key) as! CourseRowController
                        row.time.setText(String(key))
                       // row.course.setText(String((key,value)))
                        //print(key,":",value)
                        
                    }
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
            
            } .resume()
        
        
        
        
    }
    
    
}
