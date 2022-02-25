//
//  Cajero.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class Cajero: NSObject, NSCoding {
    var CAJERO_ID: Int?
    var NOMBRE, USUARIO: String?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let CAJERO_ID = aDecoder.decodeObjectForKey("CAJERO_ID") as? Int {
            self.CAJERO_ID = CAJERO_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let CAJERO_ID = CAJERO_ID {
            aCoder.encodeObject(CAJERO_ID, forKey: "CAJERO_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [Cajero] {
        var cajeros = [Cajero]()
        for (_,subJson):(String, JSON) in json {
            let cajero = Cajero()
            if let cajero_id = Int(subJson["CAJERO_ID"].string!) {
                cajero.CAJERO_ID = cajero_id
            }
            if let nombre = subJson["NOMBRE"].string {
                cajero.NOMBRE = nombre
            }
            cajeros.append(cajero)
        }
        return cajeros
    }
    
    class func parse(json: JSON) -> Cajero {
        let cajero = Cajero()
        if let cajero_id = json["CAJERO_ID"].int {
            cajero.CAJERO_ID = cajero_id
        }
        if let nombre = json["NOMBRE"].string {
            cajero.NOMBRE = nombre
        }
        if let usuario = json["USUARIO"].string {
            cajero.USUARIO = usuario
        }
        return cajero
    }
}