//
//  Almacen.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class Almacen: NSObject, NSCoding {
    var ALMACEN_ID: Int?
    var NOMBRE, ES_PREDET: String?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let ALMACEN_ID = aDecoder.decodeObjectForKey("ALMACEN_ID") as? Int {
            self.ALMACEN_ID = ALMACEN_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let ALMACEN_ID = ALMACEN_ID {
            aCoder.encodeObject(ALMACEN_ID, forKey: "ALMACEN_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [Almacen] {
        var almacenes = [Almacen]()
        for (_,subJson):(String, JSON) in json {
            let almacen = Almacen()
            if let almacen_id = Int(subJson["ALMACEN_ID"].string!) {
                almacen.ALMACEN_ID = almacen_id
            }
            if let nombre = subJson["NOMBRE"].string {
                almacen.NOMBRE = nombre
            }
            if let es_predet = subJson["ES_PREDET"].string {
                almacen.ES_PREDET = es_predet
            }
            almacenes.append(almacen)
        }
        return almacenes
    }
    
    class func parse(json: JSON) -> Almacen {
        let almacen = Almacen()
        if let almacen_id = json["ALMACEN_ID"].int {
            almacen.ALMACEN_ID = almacen_id
        }
        if let nombre = json["NOMBRE"].string {
            almacen.NOMBRE = nombre
        }
        if let es_predet = json["ES_PREDET"].string {
            almacen.ES_PREDET = es_predet
        }
        return almacen
    }
}