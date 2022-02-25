//
//  NivelArticulo.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class NivelArticulo: NSObject, NSCoding {
    var NIVEL_ART_ID, ARTICULO_ID: Int?
    var NOMBRE, LOCALIZACION, ALMACEN: String?
    var INVENTARIO_MAXIMO, INVENTARIO_MINIMO, PUNTO_REORDEN: Double?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let NIVEL_ART_ID = aDecoder.decodeObjectForKey("NIVEL_ART_ID") as? Int {
            self.NIVEL_ART_ID = NIVEL_ART_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let NIVEL_ART_ID = NIVEL_ART_ID {
            aCoder.encodeObject(NIVEL_ART_ID, forKey: "NIVEL_ART_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [NivelArticulo] {
        var nivelesArticulo = [NivelArticulo]()
        for (_,subJson):(String, JSON) in json {
            let nivelArticulo = NivelArticulo()
            if let nivelArticulo_id = Int(subJson["NIVEL_ART_ID"].string!) {
                nivelArticulo.NIVEL_ART_ID = nivelArticulo_id
            }
            if let nombre = subJson["NOMBRE"].string {
                nivelArticulo.NOMBRE = nombre
            }
            nivelesArticulo.append(nivelArticulo)
        }
        return nivelesArticulo
    }
    
    class func parse(json: JSON) -> NivelArticulo {
        let nivelArticulo = NivelArticulo()
        if let articulo_id = json["ARTICULO_ID"].int  {
            nivelArticulo.NIVEL_ART_ID = articulo_id
        }
        if let nivelArticulo_id = json["NIVEL_ART_ID"].int {
            nivelArticulo.NIVEL_ART_ID = nivelArticulo_id
        }
        if let nombre = json["NOMBRE"].string {
            nivelArticulo.NOMBRE = nombre
        }
        if let localizacion = json["LOCALIZACION"].string {
            nivelArticulo.LOCALIZACION = localizacion
        }
        if let inventario_maximo = Double(json["INVENTARIO_MAXIMO"].string!) {
            nivelArticulo.INVENTARIO_MAXIMO = inventario_maximo
        }
        if let inventario_minimo = Double(json["INVENTARIO_MINIMO"].string!) {
            nivelArticulo.INVENTARIO_MINIMO = inventario_minimo
        }
        if let punto_reorden = Double(json["PUNTO_REORDEN"].string!) {
            nivelArticulo.PUNTO_REORDEN = punto_reorden
        }
        return nivelArticulo
    }
}