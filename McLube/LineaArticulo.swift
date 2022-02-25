//
//  LineaArticulo.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class LineaArticulo: NSObject, NSCoding {
    var LINEA_ARTICULO_ID: Int?
    var NOMBRE, ES_PREDET: String?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let LINEA_ARTICULO_ID = aDecoder.decodeObjectForKey("LINEA_ARTICULO_ID") as? Int {
            self.LINEA_ARTICULO_ID = LINEA_ARTICULO_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let LINEA_ARTICULO_ID = LINEA_ARTICULO_ID {
            aCoder.encodeObject(LINEA_ARTICULO_ID, forKey: "LINEA_ARTICULO_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [LineaArticulo] {
        var lineasArticulos = [LineaArticulo]()
        for (_,subJson):(String, JSON) in json {
            let lineaArticulo = LineaArticulo()
            if let lineaArticulo_id = Int(subJson["LINEA_ARTICULO_ID"].string!) {
                lineaArticulo.LINEA_ARTICULO_ID = lineaArticulo_id
            }
            if let nombre = subJson["NOMBRE"].string {
                lineaArticulo.NOMBRE = nombre
            }
            if let es_predet = subJson["ES_PREDET"].string {
                lineaArticulo.ES_PREDET = es_predet
            }
            lineasArticulos.append(lineaArticulo)
        }
        return lineasArticulos
    }
    
    class func parse(json: JSON) -> LineaArticulo {
        let lineaArticulo = LineaArticulo()
        if let lineaArticulo_id = json["LINEA_ARTICULO_ID"].int {
            lineaArticulo.LINEA_ARTICULO_ID = lineaArticulo_id
        }
        if let nombre = json["NOMBRE"].string {
            lineaArticulo.NOMBRE = nombre
        }
        if let es_predet = json["ES_PREDET"].string {
            lineaArticulo.ES_PREDET = es_predet
        }
        return lineaArticulo
    }
}