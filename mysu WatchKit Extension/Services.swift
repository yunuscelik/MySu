//
//  Services.swift
//  mysu WatchKit Extension
//
//  Created by ynsclk on 21.02.2020.
//  Copyright © 2020 ynsclk. All rights reserved.
//

import WatchKit

//class Services: NSObject {

    
    
    func getMeals() -> [Meal]{
        var Meals = [Meal] ()
        let urlMeal = "https://www.sabanciuniv.edu/apps/test/meal.php" // todays menu
        let urlObjMeal = URL(string: urlMeal)
        URLSession.shared.dataTask(with: urlObjMeal!)  { (data , response , error) in
            do {
                Meals = try JSONDecoder().decode([Meal].self, from : data! )
                
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
            } catch {
                print("we got an error")
            }
            
            }.resume()
        
        
        
        
        return Meals
    }
//}
