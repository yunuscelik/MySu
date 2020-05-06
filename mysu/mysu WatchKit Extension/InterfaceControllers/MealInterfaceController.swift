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
    var today = Date()
    var DateURL : String = ""
    let dateFormatter1 = DateFormatter()
    
    @IBOutlet weak var DayTitle: WKInterfaceLabel!
    
    var MealData : [NSDictionary] =  []
    
    @IBOutlet weak var infoLabel: WKInterfaceLabel!
   
    var NoResultDict : [NSDictionary] = [[ "meal_en" : " No Result" ,"meal" : " Veri Yok", "calorie": "" , "lunch":false , "dinner":false ]]
    
    @IBOutlet weak var MealTable: WKInterfaceTable!
    

    
    
    @IBAction func NextDay() {
        today = Calendar.current.date(byAdding: .day, value: +1, to: today)!
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        self.DateURL = dateFormatter1.string(from: today)
        self.DayTitle.setText(self.DateURL)
        loadMealData()
        if(settingsReload.Language == "TR" ){
            self.infoLabel.setText("Yükleniyor...")
        }
        else{
            self.infoLabel.setText("Loading Data...")
            
        }
        
    }
    
    
    @IBAction func PrevDay() {
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        self.DateURL = dateFormatter1.string(from: today)
        self.DayTitle.setText(self.DateURL)
        loadMealData()
        if(settingsReload.Language == "TR" ){
            self.infoLabel.setText("Yükleniyor...")
        }
        else{
            self.infoLabel.setText("Loading Data...")

        }
    
    }
    @IBAction func rigthSwipe(_ sender: Any) {
        self.PrevDay()
    }
    
    @IBAction func leftSwipe(_ sender: Any) {
        self.NextDay()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if(settingsReload.Language == "TR" ){
            self.infoLabel.setText("Yükleniyor...")
        }
        else{
            self.infoLabel.setText("Loading Data...")
            
        }
        
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        self.DateURL = dateFormatter1.string(from: today)
        self.DayTitle.setText(self.DateURL)
        loadMealData()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    func loadMealData( ) {
        
        
        let urlwithdate = "https://www.sabanciuniv.edu/apps/test/meal.php?sdate=2020-01-09&edate=2020-01-09"
        
        let urlMeal = "https://www.sabanciuniv.edu/apps/test/meal.php?sdate=" + self.DateURL + "&edate=" +  self.DateURL // todays menu
  
        
        var urlObjMeal = URLRequest(url: URL(string:urlMeal)!)
        
        
        let d = Days()
        let date = d.getTodayDate()
        if(settingsReload.Meal == date) {
            urlObjMeal.cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
            
        }
        else {
            URLCache.shared.removeCachedResponse(for: urlObjMeal)
            urlObjMeal.cachePolicy = URLRequest.CachePolicy.reloadRevalidatingCacheData
            settingsReload.Meal = date
            
        }
        URLSession.shared.dataTask(with: urlObjMeal)  { (data , response , error) in
            do {
                self.infoLabel.setText("")
                if (data == nil ) {
                    if(settingsReload.Language == "TR" ){
                        self.infoLabel.setText("Bağlantı Hatası !")
                    }
                    else{
                        self.infoLabel.setText("Error in connection")
                    }
                    
                }
                else {
                    
                
                let arbitrary = try JSONSerialization.jsonObject(with: data!,options: .mutableContainers) as! NSArray
                    
                //let Meals1 : NSArray = try JSONDecoder().decode(NSArray, from : data! )
                
                let dict = arbitrary as? [NSDictionary]
                    
                if (dict == nil || dict!.count == 0 ) {
                    self.MealData = self.NoResultDict
                }
                else {
                    self.MealData = dict!
                }
                self.loadMeal()
                }
                
            
            }catch let DecodingError.dataCorrupted(context) {
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
   
    
    
    
    func loadMeal () {
        let Meals = self.MealData
        
        
        self.MealTable.setNumberOfRows(Meals.count, withRowType: "MealRowController")
        var i = 0
        for meal in Meals {
            var mealkey: String = "meal_en"
            if(settingsReload.Language == "TR" ){
                mealkey = "meal"
            }
            
            //let meal = Meals[i] as! NSDictionary
            let row = self.MealTable.rowController(at: i) as! MealRowController
             i = i + 1
            let mealName = meal.value(forKey: mealkey) as? String
            row.MealName.setText(mealName)
            
            var time  = ""
            let lunch = meal.value(forKey: "lunch") as? Bool ?? false
            let dinner = meal.value(forKey: "dinner") as? Bool ?? false
            
          
            if(settingsReload.Language == "TR" ){
                if  (lunch){
                    time = "ÖĞLE"
                }
                else if dinner {
                    time = "AKŞAM"
                }
                else if (lunch && dinner ) {
                    time = "ÖĞLE,AKŞAM"
                }
            }
            else {
                
                if  (lunch){
                    time = "LUNCH"
                }
                else if dinner {
                    time = "DINNER"
                }
                else if (lunch && dinner ) {
                    time = "LUNCH,DINNER"
                }
            }
            
            row.Time.setText(time)
            
            var clr = ""
            if let cal = meal.value(forKey: "calorie") as? Int {
                clr = "Cal: " + String(cal)
            }

            
            row.Calorie.setText( clr )
        }
        
        
    }
    
}
