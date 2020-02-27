//
//  InterfaceController.swift
//  mysu WatchKit Extension
//
//  Created by ynsclk on 21.02.2020.
//  Copyright © 2020 ynsclk. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBAction func MealButton() {
        pushController(withName: "MealInterfaceController", context: (Any).self)
       // loadMealData(MealInterfaceController)
      
     
       
    }
    @IBAction func ScheduleButton() {
        pushController(withName: "CourseInterface", context: (Any).self)
       
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
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






}
