//
//  ShuttleDaysInterfaceController.swift
//  mysu WatchKit Extension
//
//  Created by ynsclk on 2.04.2020.
//  Copyright © 2020 ynsclk. All rights reserved.
//

import WatchKit
import Foundation
class ShuttleHour {
    let title : String
    let hours : NSDictionary
    init( t : String, hrs : NSDictionary) {
        title = t
        hours = hrs
    }
}

class ShuttleDaysInterfaceController: WKInterfaceController {
    var myRoute : NSDictionary = [:]
    @IBOutlet weak var DayTable: WKInterfaceTable!
    @IBOutlet weak var label: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let route = context as! NSDictionary
        myRoute = route
        label.setText(route.value(forKey: "route_name_eng") as! String )
        
        
        self.DayTable.setNumberOfRows(route.allKeys.count-2, withRowType: "ShuttleDayRowController")
        
        
        for (index ) in 0...route.allKeys.count-3  {
            
            
            let row = self.DayTable.rowController(at:index) as! ShuttleDayRowController
            row.DayLabel.setText(route.allKeys[index+2] as! String)
            
            }
        }
    
    
    
    
        override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
            let shuttle = ShuttleHour(t: myRoute.value(forKey: "route_name_eng") as! String,hrs: myRoute.allValues[rowIndex+2] as! NSDictionary)
        pushController(withName: "ShuttleHourInterfaceController",
                       context: shuttle)
            
        //print(routes[0])
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
