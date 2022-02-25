//
//  Cobrador.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class Cobrador: NSObject, NSCoding {
    var COBRADOR_ID: Int?
    var NOMBRE, ES_PREDET: String?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let COBRADOR_ID = aDecoder.decodeObjectForKey("COBRADOR_ID") as? Int {
            self.COBRADOR_ID = COBRADOR_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let COBRADOR_ID = COBRADOR_ID {
            aCoder.encodeObject(COBRADOR_ID, forKey: "COBRADOR_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [Cobrador] {
        var cobradores = [Cobrador]()
        for (_,subJson):(String, JSON) in json {
            let cobrador = Cobrador()
            if let cobrador_id = Int(subJson["COBRADOR_ID"].string!) {
                cobrador.COBRADOR_ID = cobrador_id
            }
            if let nombre = subJson["NOMBRE"].string {
                cobrador.NOMBRE = nombre
            }
            if let es_predet = subJson["ES_PREDET"].string {
                cobrador.ES_PREDET = es_predet
            }
            cobradores.append(cobrador)
        }
        return cobradores
    }
    
    class func parse(json: JSON) -> Cobrador {
        let cobrador = Cobrador()
        if let cobrador_id = json["COBRADOR_ID"].int {
            cobrador.COBRADOR_ID = cobrador_id
        }
        if let nombre = json["NOMBRE"].string {
            cobrador.NOMBRE = nombre
        }
        if let es_predet = json["ES_PREDET"].string {
            cobrador.ES_PREDET = es_predet
        }
        return cobrador
    }
}