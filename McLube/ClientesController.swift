//
//  ClientesController.swift
//  McLube
//
//  Created by Jorge Zamarrón on 06/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class ClientesController {
    
    class func index(clientesList: ClientesList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "clientes")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let clientes = Cliente.parseList(r)
                    clientesList.clientes = clientes
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func buscar(q: String, clientesList: ClientesList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "clientes?q=" + q.stringByReplacingOccurrencesOfString(" ", withString: "%20"))!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let clientes = Cliente.parseList(r)
                    clientesList.clientes = clientes
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func crear(parameters: [String: AnyObject], completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "cliente/crear")!
        let api_call = API(url: url)
        api_call.post(parameters) { (result) -> Void in
            if (result != nil) {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func mostrar(id: Int, completion: Cliente -> Void) {
        let url = NSURL(string: API.apiURL() + "cliente/" + String(id))!
        let api_call = API(url: url)
        var cliente: Cliente?
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    cliente = Cliente.parse(r)
                    completion(cliente!)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(cliente!)
                }
            }
        }
    }
}