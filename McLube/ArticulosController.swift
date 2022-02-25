//
//  ArticulosController.swift
//  McLube
//
//  Created by Jorge Zamarrón on 06/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class ArticulosController {
    
    class func index(articulosList: ArticulosList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "articulos")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let articulos = Articulo.parseList(r)
                    articulosList.articulos = articulos
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func lineas(lineasList: LineasArticulosList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "lineas-articulos")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let lineas = LineaArticulo.parseList(r)
                    lineasList.lineasArticulos = lineas
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func lineas_articulos(id: Int, articulosList: ArticulosList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "articulos/linea/" + String(id))!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let articulos = Articulo.parseList(r)
                    articulosList.articulos = articulos
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }

    
    class func mostrar(id: Int, completion: Articulo -> Void) {
        let url = NSURL(string: API.apiURL() + "articulo/" + String(id))!
        let api_call = API(url: url)
        var articulo: Articulo?
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    articulo = Articulo.parse(r)
                    completion(articulo!)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(articulo!)
                }
            }
        }
    }
    
    class func mostrar_docto(id: String, parameters: String, completion: DocumentoPV.Articulo -> Void) {
        let url = NSURL(string: API.apiURL() + "articulo/" + id + "?" + parameters)!
        let api_call = API(url: url)
        var articulo: DocumentoPV.Articulo?
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    articulo = Articulo.parse_docto(r)
                    completion(articulo!)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(articulo!)
                }
            }
        }
    }

}