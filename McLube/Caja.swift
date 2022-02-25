//
//  Caja.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class Caja: NSObject, NSCoding {
    var CAJA_ID, ALMACEN_ID, FORMA_COBRO_PREDET_ID: Int?
    var NOMBRE, MODIFICAR_ALMACEN: String?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let CAJA_ID = aDecoder.decodeObjectForKey("CAJA_ID") as? Int {
            self.CAJA_ID = CAJA_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let CAJA_ID = CAJA_ID {
            aCoder.encodeObject(CAJA_ID, forKey: "CAJA_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [Caja] {
        var cajas = [Caja]()
        for (_,subJson):(String, JSON) in json {
            let caja = Caja()
            if let caja_id = Int(subJson["CAJA_ID"].string!) {
                caja.CAJA_ID = caja_id
            }
            if let nombre = subJson["NOMBRE"].string {
                caja.NOMBRE = nombre
            }
            if let es_predet = subJson["MODIFICAR_ALMACEN"].string {
                caja.MODIFICAR_ALMACEN = es_predet
            }
            cajas.append(caja)
        }
        return cajas
    }
    
    class func parse(json: JSON) -> Caja {
        let caja = Caja()
        if let caja_id = json["CAJA_ID"].int {
            caja.CAJA_ID = caja_id
        }
        if let nombre = json["NOMBRE"].string {
            caja.NOMBRE = nombre
        }
        if let es_predet = json["MODIFICAR_ALMACEN"].string {
            caja.MODIFICAR_ALMACEN = es_predet
        }
        if let almacen_id = json["ALMACEN_ID"].int {
            caja.ALMACEN_ID = almacen_id
        }
        if let forma_cobro_predet_id = json["FORMA_COBRO_PREDET_ID"].int {
            caja.FORMA_COBRO_PREDET_ID = forma_cobro_predet_id
        }
        return caja
    }
}