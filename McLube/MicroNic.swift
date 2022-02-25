//
//  MicroNic.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class MicroNic {
    
    class func getAPI() -> String {
        if let api = NSUserDefaults.standardUserDefaults().objectForKey("api") as? String {
           return api
        } else {
            return "http://api.dev"
        }
    }
    
    class func setAPI(string: String) {
        let api = string
        NSUserDefaults.standardUserDefaults().setObject(api, forKey: "api")
    }
    
    class func getUSUARIO() -> String {
        if let usuario = NSUserDefaults.standardUserDefaults().objectForKey("usuario") as? String {
            return usuario
        } else {
            return ""
        }
    }
    
    class func setUSUARIO(string: String) {
        let usuario = string
        NSUserDefaults.standardUserDefaults().setObject(usuario, forKey: "usuario")
    }
    
    class func getCAJA() -> Int {
        if let caja = NSUserDefaults.standardUserDefaults().objectForKey("caja") as? Int {
            return caja
        } else {
            return 0
        }
    }

    class func setCAJA(id: Int) {
        let caja = id
        NSUserDefaults.standardUserDefaults().setObject(caja, forKey: "caja")
    }
    
    class func getCAJERO() -> Int {
        if let cajero = NSUserDefaults.standardUserDefaults().objectForKey("cajero") as? Int {
            return cajero
        } else {
            return 0
        }
    }
    
    class func setCAJERO(id: Int) {
        let cajero = id
        NSUserDefaults.standardUserDefaults().setObject(cajero, forKey: "cajero")
    }
    
    class func getDoubleToCurrency(number: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(number)!
    }
    
    class func getNSDateToString(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.stringFromDate(date)
    }
    
    class func getStringToNSDate(string: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.dateFromString(string)!
    }
}

    

