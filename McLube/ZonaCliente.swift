//
//  ZonaCliente.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class ZonaCliente: NSObject, NSCoding {
    var ZONA_CLIENTE_ID: Int?
    var NOMBRE, ES_PREDET: String?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let ZONA_CLIENTE_ID = aDecoder.decodeObjectForKey("ZONA_CLIENTE_ID") as? Int {
            self.ZONA_CLIENTE_ID = ZONA_CLIENTE_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let ZONA_CLIENTE_ID = ZONA_CLIENTE_ID {
            aCoder.encodeObject(ZONA_CLIENTE_ID, forKey: "ZONA_CLIENTE_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [ZonaCliente] {
        var zonaClientes = [ZonaCliente]()
        for (_,subJson):(String, JSON) in json {
            let zonaCliente = ZonaCliente()
            if let zonaCliente_id = Int(subJson["ZONA_CLIENTE_ID"].string!) {
                zonaCliente.ZONA_CLIENTE_ID = zonaCliente_id
            }
            if let nombre = subJson["NOMBRE"].string {
                zonaCliente.NOMBRE = nombre
            }
            if let es_predet = subJson["ES_PREDET"].string {
                zonaCliente.ES_PREDET = es_predet
            }
            zonaClientes.append(zonaCliente)
        }
        return zonaClientes
    }
    
    class func parse(json: JSON) -> ZonaCliente {
        let zonaCliente = ZonaCliente()
        if let zonaCliente_id = json["ZONA_CLIENTE_ID"].int {
            zonaCliente.ZONA_CLIENTE_ID = zonaCliente_id
        }
        if let nombre = json["NOMBRE"].string {
            zonaCliente.NOMBRE = nombre
        }
        if let es_predet = json["ES_PREDET"].string {
            zonaCliente.ES_PREDET = es_predet
        }
        return zonaCliente
    }
}