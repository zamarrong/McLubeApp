//
//  DocumentoPV.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class DocumentoPV: NSObject, NSCoding {
    var DOCTO_PV_ID, CAJA_ID, CAJERO_ID, CLIENTE_ID, DIR_CLI_ID, ALMACEN_ID, MONEDA_ID, VENDEDOR_ID: Int?
    var TIPO_DOCTO, FOLIO, HORA, CLAVE_CLIENTE, TIPO_DSCTO, ESTATUS, APLICADO, DESCRIPCION, PERSONA, USUARIO: String?
    var TIPO_CAMBIO, DSCTO_PCTJE, DSCTO_IMPORTE, IMPORTE_NETO, TOTAL_IMPUESTOS, TOTAL_FPGC: Double?
    var FECHA: NSDate?
    
    class Articulo {
        var ARTICULO_ID, DOCTO_PV_DET_ID, DOCTO_PV_ID: Int?
        var NOMBRE, CLAVE_ARTICULO: String?
        var UNIDADES, PRECIO, PRECIO_UNITARIO, PRECIO_TOTAL_NETO, STOCK: Double?
    }
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let DOCTO_PV_ID = aDecoder.decodeObjectForKey("DOCTO_PV_ID") as? Int {
            self.DOCTO_PV_ID = DOCTO_PV_ID
        }
        if let FOLIO = aDecoder.decodeObjectForKey("FOLIO") as? String {
            self.FOLIO = FOLIO
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let DOCTO_PV_ID = DOCTO_PV_ID {
            aCoder.encodeObject(DOCTO_PV_ID, forKey: "DOCTO_PV_ID")
        }
        if let folio = FOLIO {
            aCoder.encodeObject(folio, forKey: "FOLIO")
        }
    }
    
    class func parseList(json: JSON) -> [DocumentoPV] {
        var documentosPV = [DocumentoPV]()
        for (_,subJson):(String, JSON) in json {
            let documentoPV = DocumentoPV()
            if let documentoPV_id = Int(subJson["DOCTO_PV_ID"].string!) {
                documentoPV.DOCTO_PV_ID = documentoPV_id
            }
            if let folio = subJson["FOLIO"].string {
                documentoPV.FOLIO = folio
            }
            if let fecha = subJson["FECHA"].string {
                documentoPV.FECHA = MicroNic.getStringToNSDate(fecha)
            }
            if let persona = subJson["PERSONA"].string {
                documentoPV.PERSONA = persona
            } else {
                documentoPV.PERSONA = ""
            }
            documentosPV.append(documentoPV)
        }
        return documentosPV
    }
    
    class func parse(json: JSON) -> DocumentoPV {
        let documentoPV = DocumentoPV()
        if let documentoPV_id = Int(json["DOCTO_PV_ID"].string!) {
            documentoPV.DOCTO_PV_ID = documentoPV_id
        }
        if let caja_id = Int(json["CAJA_ID"].string!) {
            documentoPV.CAJA_ID = caja_id
        }
        if let tipo_documento = json["TIPO_DOCTO"].string {
            documentoPV.TIPO_DOCTO = tipo_documento
        }
        if let folio = json["FOLIO"].string {
            documentoPV.FOLIO = folio
        }
        if let fecha = json["FECHA"].string {
            documentoPV.FECHA = MicroNic.getStringToNSDate(fecha)
        }
        if let cajero_id = Int(json["CAJERO_ID"].string!) {
            documentoPV.CAJERO_ID = cajero_id
        }
        if let clave_cliente = json["CLAVE_CLIENTE"].string {
            documentoPV.CLAVE_CLIENTE = clave_cliente
        }
        if let cliente_id = Int(json["CLIENTE_ID"].string!) {
            documentoPV.CLIENTE_ID = cliente_id
        }
        if let almacen_id = Int(json["ALMACEN_ID"].string!) {
            documentoPV.ALMACEN_ID = almacen_id
        }
        if let persona = json["PERSONA"].string {
            documentoPV.PERSONA = persona
        } else {
            documentoPV.PERSONA = ""
        }
        if let importe_neto = Double(json["IMPORTE_NETO"].string!) {
            documentoPV.IMPORTE_NETO = importe_neto
        }
        if let total_impuestos = Double(json["TOTAL_IMPUESTOS"].string!) {
            documentoPV.TOTAL_IMPUESTOS = total_impuestos
        }
        return documentoPV
    }
    
    class func parseDetails(json: JSON) -> [DocumentoPV.Articulo] {
        var articulosDocumentoPV = [DocumentoPV.Articulo()]
        for (_,subJson):(String, JSON) in json {
            let articuloDocumentoPV = DocumentoPV.Articulo()
            if let documentoPV_id = Int(subJson["DOCTO_PV_ID"].string!) {
                articuloDocumentoPV.DOCTO_PV_ID = documentoPV_id
            }
            if let articuloDocumentoPV_id = Int(subJson["DOCTO_PV_DET_ID"].string!) {
                articuloDocumentoPV.DOCTO_PV_DET_ID = articuloDocumentoPV_id
            }
            if let clave_articulo = subJson["CLAVE_ARTICULO"].string {
                articuloDocumentoPV.CLAVE_ARTICULO = clave_articulo
            }
            if let articulo_id = Int(subJson["ARTICULO_ID"].string!) {
                articuloDocumentoPV.ARTICULO_ID = articulo_id
            }
            if let nombre = subJson["NOMBRE"].string {
                articuloDocumentoPV.NOMBRE = nombre
            }
            if let unidades = Double(subJson["UNIDADES"].string!) {
                articuloDocumentoPV.UNIDADES = unidades
            }
            if let precio_unitario = Double(subJson["PRECIO_UNITARIO"].string!) {
                articuloDocumentoPV.PRECIO_UNITARIO = precio_unitario
            }
            if let precio_unitario_impto = Double(subJson["PRECIO_UNITARIO_IMPTO"].string!) {
                articuloDocumentoPV.PRECIO = precio_unitario_impto
            }
            if let precio_total_neto = Double(subJson["PRECIO_TOTAL_NETO"].string!) {
                articuloDocumentoPV.PRECIO_TOTAL_NETO = precio_total_neto
            }
            articulosDocumentoPV.append(articuloDocumentoPV)
        }
        articulosDocumentoPV.removeAtIndex(0)
        return articulosDocumentoPV
    }
}