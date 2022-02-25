//
//  TipoCliente.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class TipoCliente: NSObject, NSCoding {
    var TIPO_CLIENTE_ID: Int?
    var NOMBRE, ES_PREDET: String?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let TIPO_CLIENTE_ID = aDecoder.decodeObjectForKey("TIPO_CLIENTE_ID") as? Int {
            self.TIPO_CLIENTE_ID = TIPO_CLIENTE_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let TIPO_CLIENTE_ID = TIPO_CLIENTE_ID {
            aCoder.encodeObject(TIPO_CLIENTE_ID, forKey: "TIPO_CLIENTE_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [TipoCliente] {
        var tiposClientes = [TipoCliente]()
        for (_,subJson):(String, JSON) in json {
            let tipoCliente = TipoCliente()
            if let tipoCliente_id = Int(subJson["TIPO_CLIENTE_ID"].string!) {
                tipoCliente.TIPO_CLIENTE_ID = tipoCliente_id
            }
            if let nombre = subJson["NOMBRE"].string {
                tipoCliente.NOMBRE = nombre
            }
            if let es_predet = subJson["ES_PREDET"].string {
                tipoCliente.ES_PREDET = es_predet
            }
            tiposClientes.append(tipoCliente)
        }
        return tiposClientes
    }
    
    class func parse(json: JSON) -> TipoCliente {
        let tipoCliente = TipoCliente()
        if let tipoCliente_id = json["TIPO_CLIENTE_ID"].int {
            tipoCliente.TIPO_CLIENTE_ID = tipoCliente_id
        }
        if let nombre = json["NOMBRE"].string {
            tipoCliente.NOMBRE = nombre
        }
        if let es_predet = json["ES_PREDET"].string {
            tipoCliente.ES_PREDET = es_predet
        }
        return tipoCliente
    }
}