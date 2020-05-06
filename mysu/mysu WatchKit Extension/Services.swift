//
//  Services.swift
//  mysu WatchKit Extension
//
//  Created by ynsclk on 21.02.2020.
//  Copyright © 2020 ynsclk. All rights reserved.
//

import WatchKit


func getMeals()   {   // ->  [Meal] {
        var mealdata : [Meal] = []
    
        let urlMeal = "https://www.sabanciuniv.edu/apps/test/meal.php" // todays menu
       // let urlObjMeal = URL(string: urlMeal)
        
        var urlObjMeal = URLRequest(url: URL(string:urlMeal)!)
        urlObjMeal.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
    
    
        URLSession.shared.dataTask(with: urlObjMeal)  { (data , response , error) in
            do {
                mealdata = try JSONDecoder().decode([Meal].self, from : data! )
                print(mealdata)
                /*
                for item in Meals {
                    mealdata.append(item)
                }
                 */
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
            }
            
            }.resume()
        }
    
    

var dictionary:[NSDictionary] = [["meal_en": "No Result"]]
func getMealC(completion: @escaping (NSArray) -> ()) {
    let urlMeal = "https://www.sabanciuniv.edu/apps/test/meal.php" // todays menu
    let sdate = "2020-01-09"
    let edate = "2020-01-09"
    let urlMeal2 = "https://www.sabanciuniv.edu/apps/test/meal.php?sdate="+sdate + "&edate=" + edate
    let urlObjMeal = URL(string: urlMeal)
    URLSession.shared.dataTask(with: urlObjMeal!, completionHandler: {(data, response, error) -> Void in
        
        if(data != nil) {
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSArray {
                //print(jsonObj)
                if(jsonObj!.count == 0){
                    completion(dictionary as! NSArray)
                }
                completion(jsonObj ?? dictionary as! NSArray) // Here's where we call the completion handler with the result once we have it
            }
            
        }
        else {
            completion(dictionary as! NSArray)
        }
        
        
    }).resume()
}

//USAGE:

/*
func getMealComplete(completion: @escaping (NSArray) -> ()) {
    let urlMeal = "https://www.sabanciuniv.edu/apps/test/meal.php" // todays menu
    let sdate = "2020-01-09"
    let edate = "2020-01-09"
    let urlMeal2 = "https://www.sabanciuniv.edu/apps/test/meal.php?sdate="+sdate + "&edate=" + edate
    let urlObjMeal = URL(string: urlMeal2)
    URLSession.shared.dataTask(with: urlObjMeal!, completionHandler: {(data, response, error) -> Void in
        
        if(data != nil) {
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSArray {
                //print(jsonObj)
                if(jsonObj!.count == 0){
                    completion(self.NoResultDict as! NSArray)
                }
                completion(jsonObj ?? self.NoResultDict as! NSArray) // Here's where we call the completion handler with the result once we have it
            }
            
        }
        else {
            completion(self.NoResultDict as! NSArray)
        }
        
        
    }).resume()
}
*/
        
/*
 getMealComplete(completion:{
 array in
 
 self.MealData = array as! [NSDictionary]
 
 self.loadMeal()
 // Or do something else with the result
 })
 
 */

//}


/*
func loadTable( Meals : [Meal] ) {
    
    self.MealTable.setNumberOfRows(Meals.count, withRowType: "MealRowController")
    for (index, Meal ) in Meals.enumerated() {
        let row = self.MealTable.rowController(at: index) as! MealRowController
        row.MealName.setText(Meal.meal_en)
        print(Meal.meal_en)
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
        row.Calorie.setText( Meal.calorie as? String)
        
    }
    
    
}
 */
