//
//  Vendedor.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class Vendedor: NSObject, NSCoding {
    var VENDEDOR_ID: Int?
    var NOMBRE, ES_PREDET: String?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let VENDEDOR_ID = aDecoder.decodeObjectForKey("VENDEDOR_ID") as? Int {
            self.VENDEDOR_ID = VENDEDOR_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let VENDEDOR_ID = VENDEDOR_ID {
            aCoder.encodeObject(VENDEDOR_ID, forKey: "VENDEDOR_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [Vendedor] {
        var vendedores = [Vendedor]()
        for (_,subJson):(String, JSON) in json {
            let vendedor = Vendedor()
            if let vendedor_id = Int(subJson["VENDEDOR_ID"].string!) {
                vendedor.VENDEDOR_ID = vendedor_id
            }
            if let nombre = subJson["NOMBRE"].string {
                vendedor.NOMBRE = nombre
            }
            if let es_predet = subJson["ES_PREDET"].string {
                vendedor.ES_PREDET = es_predet
            }
            vendedores.append(vendedor)
        }
        return vendedores
    }
    
    class func parse(json: JSON) -> Vendedor {
        let vendedor = Vendedor()
        if let vendedor_id = json["VENDEDOR_ID"].int {
            vendedor.VENDEDOR_ID = vendedor_id
        }
        if let nombre = json["NOMBRE"].string {
            vendedor.NOMBRE = nombre
        }
        if let es_predet = json["ES_PREDET"].string {
            vendedor.ES_PREDET = es_predet
        }
        return vendedor
    }
}