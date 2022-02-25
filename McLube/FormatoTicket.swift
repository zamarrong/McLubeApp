//
//  FormatoTicket.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class FormatoTicket: NSObject, NSCoding {
    var FORMATO_TICKET_ID: Int?
    var NOMBRE, USO: String?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let FORMATO_TICKET_ID = aDecoder.decodeObjectForKey("FORMATO_TICKET_ID") as? Int {
            self.FORMATO_TICKET_ID = FORMATO_TICKET_ID
        }
        if let NOMBRE = aDecoder.decodeObjectForKey("NOMBRE") as? String {
            self.NOMBRE = NOMBRE
        }
    }
    
    //MARK: NSCoding methods
    func encodeWithCoder(aCoder: NSCoder) {
        if let FORMATO_TICKET_ID = FORMATO_TICKET_ID {
            aCoder.encodeObject(FORMATO_TICKET_ID, forKey: "FORMATO_TICKET_ID")
        }
        if let nombre = NOMBRE {
            aCoder.encodeObject(nombre, forKey: "NOMBRE")
        }
    }
    
    class func parseList(json: JSON) -> [FormatoTicket] {
        var formatosTicket = [FormatoTicket]()
        for (_,subJson):(String, JSON) in json {
            let formatoTicket = FormatoTicket()
            if let formatoTicket_id = Int(subJson["FORMATO_TICKET_ID"].string!) {
                formatoTicket.FORMATO_TICKET_ID = formatoTicket_id
            }
            if let nombre = subJson["NOMBRE"].string {
                formatoTicket.NOMBRE = nombre
            }
            if let uso = subJson["USO"].string {
                formatoTicket.USO = uso
            }
            formatosTicket.append(formatoTicket)
        }
        return formatosTicket
    }
    
    class func parse(json: JSON) -> FormatoTicket {
        let formatoTicket = FormatoTicket()
        if let formatoTicket_id = json["FORMATO_TICKET_ID"].int {
            formatoTicket.FORMATO_TICKET_ID = formatoTicket_id
        }
        if let nombre = json["NOMBRE"].string {
            formatoTicket.NOMBRE = nombre
        }
        if let uso = json["USO"].string {
            formatoTicket.USO = uso
        }
        return formatoTicket
    }
}