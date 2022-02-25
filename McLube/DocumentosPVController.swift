//
//  DocumentosPVController.swift
//  McLube
//
//  Created by Jorge Zamarrón on 06/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class DocumentosPVController {
    
    class func index(parameters: String, documentosPVList: DocumentosPVList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "pos" + parameters)!
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
    
    class func crear(parameters: [String: AnyObject], completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "pos/crear")!
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
    
    class func mostrar(id: Int, completion: DocumentoPV -> Void) {
        let url = NSURL(string: API.apiURL() + "pos/" + String(id))!
        let api_call = API(url: url)
        var documentoPV: DocumentoPV?
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    documentoPV = DocumentoPV.parse(r)
                    completion(documentoPV!)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(documentoPV!)
                }
            }
        }
    }
    
    class func detalles(id: Int, articulosPVList: ArticulosDocumentoPVList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "pos/" + String(id) + "/detalles")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let articulosPV = DocumentoPV.parseDetails(r)
                    articulosPVList.articulosDocumentoPV = articulosPV
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