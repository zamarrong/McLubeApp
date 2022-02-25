//
//  Articulo.swift
//  McLube
//
//  Created by Jorge Zamarrón on 06/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class Articulo : NSObject, NSCoding {
    var ARTICULO_ID, LINEA_ARTICULO_ID: Int?
    var NOMBRE, ESTATUS, UNIDAD_VENTA, UNIDAD_COMPRA, LINEA_ARTICULO, MONEDA: String?
    var PRECIO, PRECIO_UNITARIO, STOCK, PESO_UNITARIO: Double?

    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let ARTICULO_ID = aDecoder.decodeObjectForKey("ARTICULO_ID") as? Int {
            self.ARTICULO_ID = ARTICULO_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let articulo_id = ARTICULO_ID {
            aCoder.encodeObject(articulo_id, forKey: "ARTICULO_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [Articulo] {
        var articulos = [Articulo]()
        for (_,subJson):(String, JSON) in json {
            let articulo = Articulo()
            if let articulo_id = Int(subJson["ARTICULO_ID"].string!) {
                articulo.ARTICULO_ID = articulo_id
            }
            if let nombre = subJson["NOMBRE"].string {
                articulo.NOMBRE = nombre
            }
            if let linea_articulo = subJson["LINEA_ARTICULO"].string {
                articulo.LINEA_ARTICULO = linea_articulo
            }
            articulos.append(articulo)
        }
        return articulos
    }
    
    class func parse(json: JSON) -> Articulo {
        let articulo = Articulo()
        if let _ = json["Error"].string {
            articulo.ARTICULO_ID = 0
            return articulo
        } else {
            if let articulo_id = Int(json["ARTICULO_ID"].string!)  {
                articulo.ARTICULO_ID = articulo_id
            }
            if let linea_articulo_id = Int(json["LINEA_ARTICULO_ID"].string!)  {
                articulo.LINEA_ARTICULO_ID = linea_articulo_id
            }
            if let nombre = json["NOMBRE"].string {
                articulo.NOMBRE = nombre
            }
            if let linea_articulo = json["LINEA_ARTICULO"].string {
                articulo.LINEA_ARTICULO = linea_articulo
            }
            if let moneda = json["MONEDA"].string {
                articulo.MONEDA = moneda
            }
            if let precio = Double(json["PRECIO"].string!) {
                articulo.PRECIO = precio
            }
            if let stock = Double(json["STOCK"].string!) {
                articulo.STOCK = stock
            }
            if let precio_unitario = Double(json["PRECIO_UNITARIO"].string!) {
                articulo.PRECIO_UNITARIO = precio_unitario
            }
            if let peso_unitario = Double(json["PESO_UNITARIO"].string!) {
                articulo.PESO_UNITARIO = peso_unitario
            }
            return articulo
        }
    }
    
    class func parse_docto(json: JSON) -> DocumentoPV.Articulo {
        let articulo = DocumentoPV.Articulo()
        if let _ = json["Error"].string {
            articulo.ARTICULO_ID = 0
        } else {
            if let articulo_id = Int(json["ARTICULO_ID"].string!)  {
                articulo.ARTICULO_ID = articulo_id
            }
            if let clave_articulo = json["CLAVE_ARTICULO"].string {
                articulo.CLAVE_ARTICULO = clave_articulo
            }
            if let nombre = json["NOMBRE"].string {
                articulo.NOMBRE = nombre
            }
            if let precio = Double(json["PRECIO"].string!) {
                articulo.PRECIO = precio
            }
            if let stock = Double(json["STOCK"].string!) {
                articulo.STOCK = stock
            }
            if let precio_unitario = Double(json["PRECIO_UNITARIO"].string!) {
                articulo.PRECIO_UNITARIO = precio_unitario
            }
        }
        return articulo
    }

}
