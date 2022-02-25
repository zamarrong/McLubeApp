//
//  ComunController.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class ComunController {
    
    class func almacenes(almacenesList: AlmacenesList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "almacenes")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let almacenes = Almacen.parseList(r)
                    almacenesList.almacenes = almacenes
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func cobradores(cobradoresList: CobradoresList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "cobradores")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let cobradores = Cobrador.parseList(r)
                    cobradoresList.cobradores = cobradores
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func vendedores(vendedoresList: VendedoresList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "vendedores")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let vendedores = Vendedor.parseList(r)
                    vendedoresList.vendedores = vendedores
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func cajas(cajasList: CajasList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "cajas")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let cajas = Caja.parseList(r)
                    cajasList.cajas = cajas
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func monedas(monedasList: MonedasList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "monedas")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let monedas = Moneda.parseList(r)
                    monedasList.monedas = monedas
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func cajeros(cajerosList: CajerosList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "cajeros")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let cajeros = Cajero.parseList(r)
                    cajerosList.cajeros = cajeros
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func usuarios(usuariosList: UsuariosList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "usuarios")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let usuarios = Usuario.parseList(r)
                    usuariosList.usuarios = usuarios
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func condiciones_pago(condicionesPagoList: CondicionesPagoList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "condiciones-pago")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let condicionesPago = CondicionPago.parseList(r)
                    condicionesPagoList.condicionesPago = condicionesPago
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func tipos_clientes(tiposClientesList: TiposClientesList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "tipos-clientes")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let tiposClientes = TipoCliente.parseList(r)
                    tiposClientesList.tiposClientes = tiposClientes
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func zonas_clientes(zonasClientesList: ZonasClientesList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "zonas-clientes")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let zonasClientes = ZonaCliente.parseList(r)
                    zonasClientesList.zonasClientes = zonasClientes
                    completion(true)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(false)
                }
            }
        }
    }
    
    class func ciudades(ciudadesList: CiudadesList, completion: Bool -> Void) {
        let url = NSURL(string: API.apiURL() + "ciudades")!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                dispatch_async(dispatch_get_main_queue()) {
                    let ciudades = Ciudad.parseList(r)
                    ciudadesList.ciudades = ciudades
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