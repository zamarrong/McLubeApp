//
//  Ciudad.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class Ciudad: NSObject, NSCoding {
    var CIUDAD_ID: Int?
    var NOMBRE, ES_PREDET: String?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let CIUDAD_ID = aDecoder.decodeObjectForKey("CIUDAD_ID") as? Int {
            self.CIUDAD_ID = CIUDAD_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let CIUDAD_ID = CIUDAD_ID {
            aCoder.encodeObject(CIUDAD_ID, forKey: "CIUDAD_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [Ciudad] {
        var ciudades = [Ciudad]()
        for (_,subJson):(String, JSON) in json {
            let ciudad = Ciudad()
            if let ciudad_id = Int(subJson["CIUDAD_ID"].string!) {
                ciudad.CIUDAD_ID = ciudad_id
            }
            if let nombre = subJson["NOMBRE"].string {
                ciudad.NOMBRE = nombre
            }
            if let es_predet = subJson["ES_PREDET"].string {
                ciudad.ES_PREDET = es_predet
            }
            ciudades.append(ciudad)
        }
        return ciudades
    }
    
    class func parse(json: JSON) -> Ciudad {
        let ciudad = Ciudad()
        if let ciudad_id = json["CIUDAD_ID"].int {
            ciudad.CIUDAD_ID = ciudad_id
        }
        if let nombre = json["NOMBRE"].string {
            ciudad.NOMBRE = nombre
        }
        if let es_predet = json["ES_PREDET"].string {
            ciudad.ES_PREDET = es_predet
        }
        return ciudad
    }
}