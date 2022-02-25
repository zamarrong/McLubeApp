//
//  VehiculosController.swift
//  McLube
//
//  Created by Jorge Zamarrón on 06/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class VehiculosController {
    
    class func index(vehiculosList: VehiculosList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "vehiculos")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let vehiculos = Vehiculo.parseList(r)
                    vehiculosList.vehiculos = vehiculos
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func cliente(id: Int, vehiculosList: VehiculosList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "vehiculos/cliente/" + String(id))!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let vehiculos = Vehiculo.parseList(r)
                    vehiculosList.vehiculos = vehiculos
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func mostrar(id: Int, completion: Vehiculo -> Void) {
        let url = NSURL(string: API.apiURL() + "vehiculo/" + String(id))!
        let api_call = API(url: url)
        var vehiculo: Vehiculo?
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    vehiculo = Vehiculo.parse(r)
                    completion(vehiculo!)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(vehiculo!)
                }
            }
        }
    }
    
    class func servicios(id: Int, documentosPVList: DocumentosPVList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "vehiculo/" + String(id) + "/servicios")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let documentosPV = DocumentoPV.parseList(r)
                    documentosPVList.documentosPV = documentosPV
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }

    class func buscar(q: String, vehiculosList: VehiculosList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "vehiculos?q=" + q.stringByReplacingOccurrencesOfString(" ", withString: "%20"))!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let vehiculos = Vehiculo.parseList(r)
                    vehiculosList.vehiculos = vehiculos
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
        let url = NSURL(string: API.apiURL() + "vehiculo/crear")!
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
    
}