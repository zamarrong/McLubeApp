//
//  Vehiculo.swift
//  McLube
//
//  Created by Jorge Zamarrón on 06/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class Vehiculo : NSObject, NSCoding {
    var VEHICULO_ID, CLIENTE_ID: Int?
    var NOMBRE, CLAVE_ARTICULO, MARCA, MODELO, COLOR: String?
    var AÑO: Int?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let VEHICULO_ID = aDecoder.decodeObjectForKey("VEHICULO_ID") as? Int {
            self.VEHICULO_ID = VEHICULO_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let vehiculo_id = VEHICULO_ID {
            aCoder.encodeObject(vehiculo_id, forKey: "VEHICULO_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [Vehiculo] {
        var vehiculos = [Vehiculo]()
        for (_,subJson):(String, JSON) in json {
            let vehiculo = Vehiculo()
            if let vehiculo_id = Int(subJson["ARTICULO_ID"].string!) {
                vehiculo.VEHICULO_ID = vehiculo_id
            }
            if let nombre = subJson["NOMBRE"].string {
                vehiculo.NOMBRE = nombre
            }
            if let clave_vehiculo = subJson["CLAVE_ARTICULO"].string {
                vehiculo.CLAVE_ARTICULO = clave_vehiculo
            }
            if let cliente_id = Int(subJson["libres"]["CLIENTE"].string!) {
                vehiculo.CLIENTE_ID = cliente_id
            }
            vehiculos.append(vehiculo)
        }
        return vehiculos
    }
    
    class func parse(json: JSON) -> Vehiculo {
        let vehiculo = Vehiculo()
        if let _ = json["Error"].string {
            vehiculo.VEHICULO_ID = 0
            return vehiculo
        } else {
            if let vehiculo_id = Int(json["ARTICULO_ID"].string!)  {
                vehiculo.VEHICULO_ID = vehiculo_id
            }
            if let cliente_id = Int(json["libres"]["CLIENTE"].string!) {
                vehiculo.CLIENTE_ID = cliente_id
            }
            if let nombre = json["NOMBRE"].string {
                vehiculo.NOMBRE = nombre
            }
            if let clave_vehiculo = json["CLAVE_ARTICULO"].string {
                vehiculo.CLAVE_ARTICULO = clave_vehiculo
            }
            if let marca = json["libres"]["MARCA"].string {
                vehiculo.MARCA = marca
            }
            if let modelo = json["libres"]["MODELO"].string {
                vehiculo.MODELO = modelo
            }
            if let color = json["libres"]["COLOR"].string {
                vehiculo.COLOR = color
            }
            if let año = Int(json["libres"]["AO"].string!) {
                vehiculo.AÑO = año
            }
            return vehiculo
        }
    }
}
