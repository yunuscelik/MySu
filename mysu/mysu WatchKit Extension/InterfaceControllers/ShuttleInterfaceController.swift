//
//  ShuttleInterfaceController.swift
//  mysu WatchKit Extension
//
//  Created by ynsclk on 5.03.2020.
//  Copyright © 2020 ynsclk. All rights reserved.
//

import WatchKit
import Foundation


class ShuttleInterfaceController: WKInterfaceController {
    
    var routes : NSArray = []
    
    @IBOutlet weak var Noresult: WKInterfaceLabel!
    @IBOutlet weak var ShuttleRoutesTitle: WKInterfaceLabel!
    @IBOutlet weak var ShuttleTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        getShuttle()
        self.Noresult.setText("Loading Data...")
        ShuttleRoutesTitle.setText("Routes")
        
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        pushController(withName: "ShuttleDaysInterfaceController",
                               context: routes[rowIndex])
        
    }
   
    override func willActivate() {
        super.willActivate()
        
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
   
    
    func generateRandomColor() -> UIColor {
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        
        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        return randomColor
    }
    
    
    private  func getShuttle() {
        print("SHUTTLE INFORMATION")
        let urlShuttle = "https://www.sabanciuniv.edu/apps/test/shuttle_json.php"
      //  let urlObjShuttle = URL(string: urlShuttle)
        
        var urlObjShuttle = URLRequest(url: URL(string:urlShuttle)!)
        
        
        let d = Days()
        let date = d.getTodayDate()
        
        if(settingsReload.Shuttle == date) {
            urlObjShuttle.cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
            
        }
        else {
            URLCache.shared.removeCachedResponse(for: urlObjShuttle)
            urlObjShuttle.cachePolicy = URLRequest.CachePolicy.reloadRevalidatingCacheData// reloadRevalidatingCacheData
            settingsReload.Shuttle = date
        }
        URLSession.shared.dataTask(with: urlObjShuttle)  { (data3,response3, error3) in
            do {
                if(data3 != nil) {
                self.Noresult.setText("")
                if(data3 != nil ) {
                let arbitrary = try JSONSerialization.jsonObject(with: data3!,options: .mutableContainers)
               
                let routes = arbitrary as! NSArray
                self.routes = routes
                self.ShuttleTable.setNumberOfRows(routes.count, withRowType: "ShuttleRowController")
                // print(routes(key_t))
                // print(routes.value(forKey:"101"))
                
                for (index ) in 0...routes.count-1  {
                    
                   let route = routes [ index ] as! NSDictionary
                  //  print((route["route_name_eng"]) as! String)
                    
                    
                    let row = self.ShuttleTable.rowController(at:index) as! ShuttleRowController
                    
                   row.RouteName.setText(route.value(forKey: "route_name_eng") as! String)
                    //row.routeGroup.setBackgroundColor(self.generateRandomColor())
                  }
                }
                else {
                   self.Noresult.setText("No Result")
                }
                }
                else {
                    self.Noresult.setText("Error in connection ")
                }
                
                
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
            
            }.resume()
        
        
    }
    
    
    private  func loadShuttle(routes: NSArray) {
        
        
                self.ShuttleTable.setNumberOfRows(routes.count, withRowType: "ShuttleRowController")
                // print(routes(key_t))
                // print(routes.value(forKey:"101"))
                
                for (index ) in 0...routes.count-1  {
                    
                    let route = routes [ index ] as! NSDictionary
                    //  print((route["route_name_eng"]) as! String)
                    
                    
                    let row = self.ShuttleTable.rowController(at:index) as! ShuttleRowController
                    row.RouteName.setText(route.value(forKey: "route_name_eng") as! String)
                    
                    
                    
        
        
    }
    
    
    
}
}
