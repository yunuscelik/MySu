//
//  ShuttleHourInterfaceController.swift
//  mysu WatchKit Extension
//
//  Created by ynsclk on 2.04.2020.
//  Copyright © 2020 ynsclk. All rights reserved.
//

import WatchKit
import Foundation


class ShuttleHourInterfaceController: WKInterfaceController {
    let Dest = ["-> To SU <-","-> From SU <-"]
    var Indest : Int = 0
    var ToSU : NSArray = []
    var FromSU : NSArray = []
    var shuttleTitle : String = ""
    @IBOutlet weak var ChangeButton: WKInterfaceButton!
    let NoResult:NSArray = ["No Result"]
    @IBAction func Change() {
        if(Indest==0){ // To SU = From destination
            ChangeButton.setTitle("To " + shuttleTitle)
            loadTable(hour: FromSU)
            Indest  = 1
        }
        else {
            ChangeButton.setTitle("From " + shuttleTitle)
            loadTable(hour: ToSU)
            Indest  = 0
            
        }
    }
    
    @IBOutlet weak var Destination: WKInterfaceLabel!
    @IBOutlet weak var HourTable: WKInterfaceTable!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let shuttle = context as! ShuttleHour
        
        ToSU = shuttle.hours["to_campus"] as? NSArray ?? NoResult
        FromSU = shuttle.hours["from_campus"] as? NSArray ?? NoResult
        shuttleTitle = shuttle.title
        
        ChangeButton.setTitle("From " + shuttleTitle)
        
        loadTable(hour: ToSU)
        
    }
         // Configure interface objects here.
    
    
    override func willActivate() { 
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    func loadTable(hour:NSArray){
        let count = hour.count as! Int
        var rowCount : Int = 0
        if((count % 2) == 0  ) {
            rowCount = count/2
        }
        else {
           rowCount = count/2 + 1
        }
        self.HourTable.setNumberOfRows(rowCount, withRowType: "ShuttleHourRowController")
        
        
        
        
        
        let date = Date()
        
        let dateFormatter1 = DateFormatter()
        let dateFormatter2 = DateFormatter()
        dateFormatter1.dateFormat = "HH"
        dateFormatter2.dateFormat = "mm"
        let Dhour = dateFormatter1.string(from: date)
        let Dminute = dateFormatter2.string(from: date)
        
        var index = 0
        var isSet :Bool = false
        for i in 0...count-1 {
            let h =  hour[i] as! String
            let b = h.split(separator: ":")
            
            let hrr = Int("\(b[0])") as! Int
            let mnn = Int("\(b[1])") as! Int
            
            if(    isSet == false   &&     (    hrr > Int(Dhour)!  || ( hrr == Int(Dhour)!   && mnn > Int(Dminute)! )  )  ){
                index = i
                isSet = true
                
            }
        }
        
        
        
        var rowIndex = 0
        while(rowIndex < rowCount)  {
            
            
            let row = self.HourTable.rowController(at:rowIndex) as! ShuttleHourRowController
            row.Hour.setText(hour[2*rowIndex] as! String)
            if(2*rowIndex == index){
                row.Hour.setTextColor(UIColor(red:0.0, green:122.0/255.0 ,blue:1.0 ,alpha:1.0))
                
            }
            
            if (2*rowIndex + 1 != count) {
                row.Hour2.setText(hour[2*rowIndex + 1] as! String)
                if(2*rowIndex + 1 == index){
                    row.Hour2.setTextColor(UIColor(red:0.0, green:122.0/255.0 ,blue:1.0 ,alpha:1.0))
                }
            }
            rowIndex = rowIndex + 1
            
    }
    }
}
