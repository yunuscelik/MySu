//
//  SuCardInterfaceController.swift
//  mysu WatchKit Extension
//
//  Created by ynsclk on 8.04.2020.
//  Copyright © 2020 ynsclk. All rights reserved.
//

import WatchKit
import Foundation


class SuCardInterfaceController: WKInterfaceController {

    @IBOutlet weak var MealTL: WKInterfaceLabel!
    @IBOutlet weak var infoLabel: WKInterfaceLabel!
    
    @IBOutlet weak var ShuttleTL: WKInterfaceLabel!
    @IBOutlet weak var PrintTL: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.infoLabel.setText("Loading Data...")
        self.MealTL.setText(    "-- ₺ "   )
        self.ShuttleTL.setText(    "-- ₺ "   )
        self.PrintTL.setText(    "-- ₺ "   )
        loadSU()
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
    func loadSU() {
        
        let url = "https://mysu.sabanciuniv.edu/apps/test/sucard.php"
        var urlObjCard = URLRequest(url: URL(string:url)!)
        urlObjCard.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        
        let dataTask = URLSession.shared.dataTask(with: urlObjCard)  { (data,response, error) in
            do {
                
                if(data != nil) {
                    let arbitrary = try JSONSerialization.jsonObject(with: data!,options: .allowFragments)
                    
                    let array = arbitrary as? NSArray
                    if(array != nil && array!.count == 1  ) {
                        let dictionary =  array![0] as? NSDictionary
                        if(dictionary != nil ) {
                            let meal = dictionary!["meal"] as! NSDictionary
                            let printer = dictionary!["print"] as! NSDictionary
                            let transport = dictionary!["transport"] as! NSDictionary
                            
                            
                            if let meal_sum = meal.value(forKey: "sum") as? String {
                                    self.MealTL.setText(   meal_sum + " ₺ " )                        }
                            else {
                               self.MealTL.setText( " !!! ")
                            }
                            
                            if let print_sum = printer.value(forKey: "sum") as? String{
                                self.PrintTL.setText(   print_sum + " ₺ " )                        }
                            else {
                                self.PrintTL.setText( " !!! ")
                            }
                            
                            
                            if  let transport_sum = transport.value(forKey: "sum") as? String {
                                self.ShuttleTL.setText(   transport_sum + " ₺ " )                        }
                            else {
                                self.ShuttleTL.setText( " !!! ")
                            }
                            self.infoLabel.setText("")
                         }
                        
                    }
                    else {
                        self.infoLabel.setText("Error in data")
                    }
                }
                else {
                    self.infoLabel.setText("Error in connection")
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
}
