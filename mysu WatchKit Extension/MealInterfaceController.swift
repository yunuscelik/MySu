//
//  MealInterfaceController.swift
//  mysu WatchKit Extension
//
//  Created by ynsclk on 21.02.2020.
//  Copyright © 2020 ynsclk. All rights reserved.
//

import WatchKit
import Foundation


class MealInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var MealTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        loadMealData()
        print("ajefnow")
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        //loadMealData()
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    func loadMealData( ) {
        
        let urlMeal = "https://www.sabanciuniv.edu/apps/test/meal.php" // todays menu
        let urlObjMeal = URL(string: urlMeal)
        URLSession.shared.dataTask(with: urlObjMeal!)  { (data , response , error) in
            do {
                var Meals = try JSONDecoder().decode([Meal].self, from : data! )
                self.MealTable.setNumberOfRows(Meals.count, withRowType: "MealRowController")
                for (index, Meal ) in Meals.enumerated() {
                    let row = self.MealTable.rowController(at: index) as! MealRowController
                    row.MealName.setText(Meal.meal_en)
                    
                    var time  = ""
                    if Meal.lunch {
                        time = "lunch"
                    }
                    else if Meal.dinner {
                        time = "dinner"
                    }
                    else if (Meal.lunch && Meal.dinner ) {
                        time = "lunch and dinner"
                    }
                    
                    row.Time.setText(time)
                    row.Calorie.setText("merhaba")
                    
                }
            }
            catch let DecodingError.dataCorrupted(context) {
                print(context)
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
            }catch {
                print("we got an error")
            }
            
            }.resume()
        
        
    }
 
}
