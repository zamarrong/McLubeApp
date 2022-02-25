//
//  Moneda.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class Moneda: NSObject, NSCoding {
    var MONEDA_ID: Int?
    var NOMBRE, ES_PREDET: String?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let MONEDA_ID = aDecoder.decodeObjectForKey("MONEDA_ID") as? Int {
            self.MONEDA_ID = MONEDA_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let MONEDA_ID = MONEDA_ID {
            aCoder.encodeObject(MONEDA_ID, forKey: "MONEDA_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [Moneda] {
        var monedas = [Moneda]()
        for (_,subJson):(String, JSON) in json {
            let moneda = Moneda()
            if let moneda_id = Int(subJson["MONEDA_ID"].string!) {
                moneda.MONEDA_ID = moneda_id
            }
            if let nombre = subJson["NOMBRE"].string {
                moneda.NOMBRE = nombre
            }
            if let es_predet = subJson["ES_PREDET"].string {
                moneda.ES_PREDET = es_predet
            }
            monedas.append(moneda)
        }
        return monedas
    }
    
    class func parse(json: JSON) -> Moneda {
        let moneda = Moneda()
        if let moneda_id = json["MONEDA_ID"].int {
            moneda.MONEDA_ID = moneda_id
        }
        if let nombre = json["NOMBRE"].string {
            moneda.NOMBRE = nombre
        }
        if let es_predet = json["ES_PREDET"].string {
            moneda.ES_PREDET = es_predet
        }
        return moneda
    }
}