//
//  CondicionPago.swift
//  McLube
//
//  Created by Jorge Zamarrón on 06/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//
import Foundation

class CondicionPago : NSObject, NSCoding {
    var COND_PAGO_ID: Int?
    var NOMBRE, ES_PREDET: String?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let COND_PAGO_ID = aDecoder.decodeObjectForKey("COND_PAGO_ID") as? Int {
            self.COND_PAGO_ID = COND_PAGO_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let COND_PAGO_ID = COND_PAGO_ID {
            aCoder.encodeObject(COND_PAGO_ID, forKey: "COND_PAGO_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [CondicionPago] {
        var condicionesPago = [CondicionPago]()
        for (_,subJson):(String, JSON) in json {
            let condicionPago = CondicionPago()
            if let condicion_pago_id = Int(subJson["COND_PAGO_ID"].string!) {
                condicionPago.COND_PAGO_ID = condicion_pago_id
            }
            if let nombre = subJson["NOMBRE"].string {
                condicionPago.NOMBRE = nombre
            }
            if let es_predet = subJson["ES_PREDET"].string {
                condicionPago.ES_PREDET = es_predet
            }
            condicionesPago.append(condicionPago)
        }
        return condicionesPago
    }
    
    class func parse(json: JSON) -> CondicionPago {
        let condicionPago = CondicionPago()
        if let condicion_pago_id = json["COND_PAGO_ID"].int {
            condicionPago.COND_PAGO_ID = condicion_pago_id
        }
        if let nombre = json["NOMBRE"].string {
            condicionPago.NOMBRE = nombre
        }
        if let es_predet = json["ES_PREDET"].string {
            condicionPago.ES_PREDET = es_predet
        }
        return condicionPago
    }
    
}