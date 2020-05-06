//
//  SettingsInterfaceController.swift
//  mysu WatchKit Extension
//
//  Created by ynsclk on 8.04.2020.
//  Copyright © 2020 ynsclk. All rights reserved.
//

import WatchKit

class SettingsInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var TRButton: WKInterfaceButton!
    @IBOutlet weak var ENButton: WKInterfaceButton!
    
    
    @IBOutlet weak var setting: WKInterfaceLabel!
    @IBOutlet weak var clearButton: WKInterfaceButton!
    @IBOutlet weak var info: WKInterfaceLabel!
    
    @IBAction func TRAction() {
        self.TRButton.setBackgroundColor(UIColor(red:0.0, green:122.0/255.0 ,blue:1.0 ,alpha:1.0))
        self.ENButton.setBackgroundColor(UIColor.lightGray)
        settingsReload.Language = "TR"
        
    }
    
    @IBAction func ENAction() {
       self.TRButton.setBackgroundColor(UIColor.lightGray)
        self.ENButton.setBackgroundColor(UIColor(red:0.0, green:122.0/255.0 ,blue:1.0 ,alpha:1.0))
        settingsReload.Language = "EN"
    }
    @IBAction func button() {
        URLCache.shared.removeAllCachedResponses()
        self.info.setText("Cleared")
        clearButton.setEnabled(false)
    }
    
    override func awake(withContext context: Any?) {
        setting.setText("Settings")
        clearButton.setTitle("Clear Local Data")
    self.info.setText("Normally your data is updated daily but if you think there is inconsistency, you can clear cached data ")
        if(settingsReload.Language == "TR"){
            self.ENButton.setBackgroundColor(UIColor.lightGray)
            self.TRButton.setBackgroundColor(UIColor(red:0.0, green:122.0/255.0 ,blue:1.0 ,alpha:1.0))
            
        }
        else{
            self.TRButton.setBackgroundColor(UIColor.lightGray)
            self.ENButton.setBackgroundColor(UIColor(red:0.0, green:122.0/255.0 ,blue:1.0 ,alpha:1.0))
            
        }
        
    }
}
