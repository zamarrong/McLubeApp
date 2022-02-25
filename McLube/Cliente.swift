//
//  Cliente.swift
//  McLube
//
//  Created by Jorge Zamarrón on 06/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//
import Foundation

class Cliente : NSObject, NSCoding {
    var CLIENTE_ID, MONEDA_ID, COND_PAGO_ID, TIPO_CLIENTE_ID, ZONA_CLIENTE_ID, COBRADOR_ID, VENDEDOR_ID: Int?
    var NOMBRE, CONTACTO1, CONTACTO2, ESTATUS: String?
    var LIMITE_CREDITO: Double?
    var DIRECCION: Direccion?
    
    class Direccion {
        var DIR_CLI_ID, CIUDAD_ID, ESTADO_ID: Int?
        var NOMBRE_CONSIG, CALLE, NOMBRE_CALLE, NUM_EXTERIOR, NUM_INTERIOR, COLONIA, POBLACION, CODIGO_POSTAL, TELEFONO1, TELEFONO2, FAX, EMAIL, RFC_CURP, ES_DIR_PPAL: String?
    }
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let CLIENTE_ID = aDecoder.decodeObjectForKey("CLIENTE_ID") as? Int {
            self.CLIENTE_ID = CLIENTE_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let cliente_id = CLIENTE_ID {
            aCoder.encodeObject(cliente_id, forKey: "CLIENTE_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [Cliente] {
        var clientes = [Cliente]()
        for (_,subJson):(String, JSON) in json {
            let cliente = Cliente()
            if let cliente_id = Int(subJson["CLIENTE_ID"].string!) {
                cliente.CLIENTE_ID = cliente_id
            }
            if let nombre = subJson["NOMBRE"].string {
                cliente.NOMBRE = nombre
            }
            clientes.append(cliente)
        }
        return clientes
    }
    
    class func parse(json: JSON) -> Cliente {
        let cliente = Cliente()
        if let cliente_id = Int(json["CLIENTE_ID"].string!)  {
            cliente.CLIENTE_ID = cliente_id
        }
        if let moneda_id = Int(json["MONEDA_ID"].string!)  {
            cliente.MONEDA_ID = moneda_id
        }
        if let cond_pago_id = Int(json["COND_PAGO_ID"].string!) {
            cliente.COND_PAGO_ID = cond_pago_id
        }
        if let tipo_cliente_id = Int(json["TIPO_CLIENTE_ID"].string!)  {
            cliente.TIPO_CLIENTE_ID = tipo_cliente_id
        }
        if let zona_cliente_id = Int(json["ZONA_CLIENTE_ID"].string!)  {
            cliente.ZONA_CLIENTE_ID = zona_cliente_id
        }
        if let cobrador_id = Int(json["COBRADOR_ID"].string!)  {
            cliente.COBRADOR_ID = cobrador_id
        }
        if let vendedor_id = Int(json["VENDEDOR_ID"].string!)  {
            cliente.VENDEDOR_ID = vendedor_id
        }
        if let nombre = json["NOMBRE"].string {
            cliente.NOMBRE = nombre
        }
        if let contacto1 = json["CONTACTO1"].string {
            cliente.CONTACTO1 = contacto1
        }
        if let contacto1 = json["CONTACTO1"].string {
            cliente.CONTACTO1 = contacto1
        }
        if let estatus = json["ESTATUS"].string {
            cliente.ESTATUS = estatus
        }
        if let limite_credito = Double(json["LIMITE_CREDITO"].string!) {
            cliente.LIMITE_CREDITO = limite_credito
        }
        
        //MARK: DIRECCION
        cliente.DIRECCION = Direccion()
        
        if json["direccion"].count > 0 {
            if let dir_cli_id = Int(json["direccion"]["DIR_CLI_ID"].string!) {
                cliente.DIRECCION!.DIR_CLI_ID = dir_cli_id
            }
            if let ciudad_id = Int(json["direccion"]["CIUDAD_ID"].string!) {
                cliente.DIRECCION!.CIUDAD_ID = ciudad_id
            }
            if let estado_id = Int(json["direccion"]["ESTADO_ID"].string!) {
                cliente.DIRECCION!.ESTADO_ID  = estado_id
            }
            if let nombre_consign = json["direccion"]["NOMBRE_CONSIGN"].string {
                cliente.DIRECCION!.NOMBRE_CONSIG = nombre_consign
            }
            if let calle = json["direccion"]["CALLE"].string {
                cliente.DIRECCION!.CALLE = calle
            }
            if let nombre_calle = json["direccion"]["NOMBRE_CALLE"].string {
                cliente.DIRECCION!.NOMBRE_CALLE = nombre_calle
            }
            if let num_exterior = json["direccion"]["NUM_EXTERIOR"].string {
                cliente.DIRECCION!.NUM_EXTERIOR = num_exterior
            }
            if let num_interior = json["direccion"]["NUM_INTERIOR"].string {
                cliente.DIRECCION!.NUM_INTERIOR = num_interior
            }
            if let colonia = json["direccion"]["COLONIA"].string {
                cliente.DIRECCION!.COLONIA = colonia
            }
            if let poblacion = json["direccion"]["POBLACION"].string {
                cliente.DIRECCION!.POBLACION = poblacion
            }
            if let cp = json["direccion"]["CODIGO_POSTAL"].string {
                cliente.DIRECCION!.CODIGO_POSTAL = cp
            }
            if let telefono1 = json["direccion"]["TELEFONO1"].string {
                cliente.DIRECCION!.TELEFONO1 = telefono1
            }
            if let telefono2 = json["direccion"]["TELEFONO2"].string {
                cliente.DIRECCION!.TELEFONO2 = telefono2
            }
            if let fax = json["direccion"]["FAX"].string {
                cliente.DIRECCION!.FAX = fax
            }
            if let email = json["direccion"]["EMAIL"].string {
                cliente.DIRECCION!.EMAIL = email
            }
            if let rfc_curp = json["direccion"]["RFC_CURP"].string {
                cliente.DIRECCION!.RFC_CURP = rfc_curp
            }
            if let es_dir_ppal = json["direccion"]["ES_DIR_PPAL"].string {
                cliente.DIRECCION!.ES_DIR_PPAL = es_dir_ppal
            }
        }
        
        return cliente
    }
}