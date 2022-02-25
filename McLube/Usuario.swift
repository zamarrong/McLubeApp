//
//  Usuario.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class Usuario: NSObject, NSCoding {
    var USUARIO_ID: Int?
    var NOMBRE: String?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let usuario = NOMBRE {
            aCoder.encodeObject(usuario, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [Usuario] {
        var usuarios = [Usuario]()
        for (_,subJson):(String, JSON) in json {
            let usuario = Usuario()
            if let nombre = subJson["NOMBRE"].string {
                usuario.NOMBRE = nombre
            }
            usuarios.append(usuario)
        }
        return usuarios
    }
    
    class func parse(json: JSON) -> Usuario {
        let usuario = Usuario()
        if let nombre = json["NOMBRE"].string {
            usuario.NOMBRE = nombre
        }
        return usuario
    }
}