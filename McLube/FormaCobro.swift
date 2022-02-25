//
//  FormaCobro.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class FormaCobro: NSObject, NSCoding {
    var FORMA_COBRO_ID: Int?
    var NOMBRE: String?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let FORMA_COBRO_ID = aDecoder.decodeObjectForKey("FORMA_COBRO_ID") as? Int {
            self.FORMA_COBRO_ID = FORMA_COBRO_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let FORMA_COBRO_ID = FORMA_COBRO_ID {
            aCoder.encodeObject(FORMA_COBRO_ID, forKey: "FORMA_COBRO_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [FormaCobro] {
        var formasCobro = [FormaCobro]()
        for (_,subJson):(String, JSON) in json {
            let formaCobro = FormaCobro()
            if let formaCobro_id = Int(subJson["FORMA_COBRO_ID"].string!) {
                formaCobro.FORMA_COBRO_ID = formaCobro_id
            }
            if let nombre = subJson["NOMBRE"].string {
                formaCobro.NOMBRE = nombre
            }
            formasCobro.append(formaCobro)
        }
        return formasCobro
    }
    
    class func parse(json: JSON) -> FormaCobro {
        let formaCobro = FormaCobro()
        if let formaCobro_id = json["FORMA_COBRO_ID"].int {
            formaCobro.FORMA_COBRO_ID = formaCobro_id
        }
        if let nombre = json["NOMBRE"].string {
            formaCobro.NOMBRE = nombre
        }
        return formaCobro
    }
}