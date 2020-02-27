//
//  Structs.swift
//  mysu WatchKit Extension
//
//  Created by ynsclk on 21.02.2020.
//  Copyright © 2020 ynsclk. All rights reserved.
//


import Foundation


struct Meal : Decodable {
    let id : Int?
    let date : String
    let meal :String
    let meal_en :String
    let calorie : String?
    let lunch :Bool
    let dinner :Bool
    
}

struct Sch: Decodable {
    var object : [ String: Day ]
}
struct Day : Codable {
    let t840 : String?
    let t940 : String?
    let t1040 : String?
    let t1140 : String?
    let t1240 : String?
    let t1340 : String?
    let t1440 : String?
    let t1540 : String?
    let t1640 : String?
    let t1740 : String?
    let t1840 : String?
    let t1940 : String?
    let t2040 : String?
    let t2140 : String?
    let t2240 : String?
    let t2340 : String?
    let t2440 : String?
    
    enum CodingKeys: String, CodingKey {
        
        case t840 = "840"
        case t940 = "940"
        case t1040 = "1040"
        case t1140 = "1140"
        case t1240 = "1240"
        case t1340 = "1340"
        case t1440 = "1440"
        case t1540 = "1540"
        case t1640 = "1640"
        case t1740 = "1740"
        case t1840 = "1840"
        case t1940 = "1940"
        case t2040 = "2040"
        case t2140 = "2140"
        case t2240 = "2240"
        case t2340 = "2340"
        case t2440 = "2440"
    }
}



struct Schedule : Decodable {
    
    struct Day : Codable {
        let t840 : String?
        let t940 : String?
        let t1040 : String?
        let t1140 : String?
        let t1240 : String?
        let t1340 : String?
        let t1440 : String?
        let t1540 : String?
        let t1640 : String?
        let t1740 : String?
        let t1840 : String?
        let t1940 : String?
        let t2040 : String?
        let t2140 : String?
        let t2240 : String?
        let t2340 : String?
        let t2440 : String?
        
        enum CodingKeys: String, CodingKey {
            
            case t840 = "840"
            case t940 = "940"
            case t1040 = "1040"
            case t1140 = "1140"
            case t1240 = "1240"
            case t1340 = "1340"
            case t1440 = "1440"
            case t1540 = "1540"
            case t1640 = "1640"
            case t1740 = "1740"
            case t1840 = "1840"
            case t1940 = "1940"
            case t2040 = "2040"
            case t2140 = "2140"
            case t2240 = "2240"
            case t2340 = "2340"
            case t2440 = "2440"
        }
        /*
         init(from decoder: Decoder) throws {
         let values = try decoder.container(keyedBy: CodingKeys.self)
         t840  = try values.decodeIfPresent(String.self, forKey: .t840)
         t940 = try values.decodeIfPresent(String.self, forKey: .t940)
         t1040 = try values.decodeIfPresent(String.self, forKey: .t1040)
         t1140 = try values.decodeIfPresent(String.self, forKey: .t1140)
         t1240 = try values.decodeIfPresent(String.self, forKey: .t1240)
         t1340 = try values.decodeIfPresent(String.self, forKey: .t1340)
         t1440 = try values.decodeIfPresent(String.self, forKey: .t1440)
         t1540 = try values.decodeIfPresent(String.self, forKey: .t1540)
         t1640 = try values.decodeIfPresent(String.self, forKey: .t1640)
         t1740 = try values.decodeIfPresent(String.self, forKey: .t1740)
         t1840 = try values.decodeIfPresent(String.self, forKey: .t1840)
         t1940 = try values.decodeIfPresent(String.self, forKey: .t1940)
         t2040 = try values.decodeIfPresent(String.self, forKey: .t2040)
         t2140 = try values.decodeIfPresent(String.self, forKey: .t2140)
         t2240 = try values.decodeIfPresent(String.self, forKey: .t2240)
         t2340 = try values.decodeIfPresent(String.self, forKey: .t2340)
         t2440 = try values.decodeIfPresent(String.self, forKey: .t2440)
         }
         */
    }
    
    
    
    
    let mon : Day?
    let tue : Day?
    let wed : Day?
    let thu : Day?
    let fri : Day?
    let sat : Array<Any>?
    let sun : Array<Any>?
    //let sat : [String]?
    //let sun : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case mon = "mon"
        case tue = "tue"
        case wed = "wed"
        case thu = "thu"
        case fri = "fri"
        case sat = "sat"
        case sun = "sun"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mon = try values.decodeIfPresent(Day.self, forKey: .mon)
        tue = try values.decodeIfPresent(Day.self, forKey: .tue)
        wed = try values.decodeIfPresent(Day.self, forKey: .wed)
        thu = try values.decodeIfPresent(Day.self, forKey: .thu)
        fri = try values.decodeIfPresent(Day.self, forKey: .fri)
        //sat = try values.decodeIfPresent(Day.self, forKey: .sat)
        //sun = try values.decodeIfPresent(Day.self, forKey: .sun)
        sat = try values.decodeIfPresent([String].self, forKey: .sat)
        sun = try values.decodeIfPresent([String].self, forKey: .sun)
    }
    
}
/*
 struct Route : Codable {
 let ROUTE_ID : Int
 let ROUTE_NAME_TR : String
 let ROUTE_NAME_ENG : String
 let stops : [Int: Stop]
 let hours : [String : Hour ]
 
 }
 struct Stop:Codable{
 
 }
 struct Hour:Codable{
 
 }
 struct Shuttle: Decodable{
 
 let routes : [Int: Route]
 
 
 
 
 }
 */
struct Shuttle: Codable {
    
    let routes :  Dictionary<String,Route> // [String :Route]
    
    struct Route : Codable {
        
        let ROUTE_ID : String
        let ROUTE_NAME_TR : String
        let rOUTE_NAME_ENG : String
        let stops : Dictionary<String,Stop>  // [String: Stop]
        let hours : Dictionary<String,Hour>  //[String : Hour ]
        
        enum CodingKeys: String, CodingKey {
            
            case ROUTE_ID //= "ROUTE_ID"
            case ROUTE_NAME_TR //= "ROUTE_NAME_TR"
            case rOUTE_NAME_ENG = "ROUTE_NAME_ENG"
            case stops = "stops"
            case hours = "hours"
        }
        /*
         init(from decoder: JSONDecoder) throws {
         let values = try decoder.decode(CodingKeys.self, from: data3)
         rOUTE_ID = try values.decodeIfPresent(String.self, forKey: .rOUTE_ID)
         rOUTE_NAME_TR = try values.decodeIfPresent(String.self, forKey: .rOUTE_NAME_TR)
         rOUTE_NAME_ENG = try values.decodeIfPresent(String.self, forKey: .rOUTE_NAME_ENG)
         stops = try values.decodeIfPresent(Stop.self, forKey: .stops)
         hours = try values.decodeIfPresent(Hour.self, forKey: .hours)
         }
         */
        struct Stop:Codable{
            let  STOP_ID:String
            let  STOP_NAME_TR : String
            let  STOP_NAME_ENG : String
            let  STOP_COORDS : String
        }
        struct Hour:Codable{
            let DAY_TEXT :  String
            let to_campus : Dictionary<String,Run> //[String : Run ]
            let from_campus : Dictionary<String,Run>  //[String : Run ]
            
            struct Run : Codable {
                let hour : String
                let descs : Dictionary<String,Descs>  //[String : Descs ]
                
                struct Descs : Codable {
                    let DESC_NUMBER :String
                    let DESC_TEXT : String
                }
                
            }
        }
        
    }
    
}






/*
 struct Course: Decodable{
 // indexes are "mon", "tue", "wed" , "thu", "fri" , "sat", "sun"
 let t8 :String
 let t9 :String
 let t10 :String
 let t11 :String
 let t12 :String
 let t13 :String
 let t14 :String
 let t15 :String
 let t16 :String
 let t17 :String
 let t18 :String
 let t19 :String
 let t20 :String
 let t21 :String
 let t22 :String
 let t23 :String
 let t24 :String
 
 
 }
 
 
 struct Schedule : Decodable {
 let mon : Course?
 let tue : Course?
 let wed : Course?
 let thu : Course?
 let fri : Course?
 let sat : Course?
 let sun : Course?
 }
 
 */

