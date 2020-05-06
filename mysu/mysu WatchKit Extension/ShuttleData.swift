//
//  ShuttleData.swift
//  mysu WatchKit Extension
//
//  Created by ynsclk on 2.04.2020.
//  Copyright © 2020 ynsclk. All rights reserved.
//

import WatchKit

class ShuttleData {
    
    var routes : NSArray = []
    
    init() {
        
        let urlShuttle = "https://www.sabanciuniv.edu/apps/test/shuttle_json.php"
        //  let urlObjShuttle = URL(string: urlShuttle)
        
        var urlObjShuttle = URLRequest(url: URL(string:urlShuttle)!)
        urlObjShuttle.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        
        URLSession.shared.dataTask(with: urlObjShuttle)  {  (data3,response3, error3) in
            do {
                
                
                let arbitrary = try JSONSerialization.jsonObject(with: data3!,options: .mutableContainers)
                //let dict = arbitrary as! Dictionary<String,Shuttle>
                //  let dict = arbitrary as! NSDictionary
                //  let shuttle = try Shuttle(from: dict as! Decoder)
                //   let routes = dict.value(forKey: "routes") as! NSDictionary
                self.routes = arbitrary as! NSArray
                
                
                
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
    
}
