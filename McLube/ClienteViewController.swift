//
//  ClienteViewController.swift
//  McLube
//
//  Created by Jorge Zamarrón on 08/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class ClienteViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var carsButton: UIBarButtonItem!
    
    //General
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var contacto1TextField: UITextField!
    @IBOutlet weak var condicionesDePagoTextField: UITextFieldWithPickerView!
    @IBOutlet weak var contacto2TextField: UITextField!
    @IBOutlet weak var tipoClienteTextField: UITextFieldWithPickerView!
    @IBOutlet weak var rfcTextField: UITextField!
    @IBOutlet weak var zonaClienteTextField: UITextFieldWithPickerView!
    @IBOutlet weak var monedaTextField: UITextFieldWithPickerView!
    @IBOutlet weak var cobradorTextField: UITextFieldWithPickerView!
    @IBOutlet weak var limiteCreditoTextField: UITextField!
    @IBOutlet weak var vendedorTextField: UITextFieldWithPickerView!
    
    //Direcciones
    @IBOutlet weak var calleTextField: UITextField!
    @IBOutlet weak var noExteriorTextField: UITextField!
    @IBOutlet weak var noInteriorTextField: UITextField!
    @IBOutlet weak var coloniaTextField: UITextField!
    @IBOutlet weak var poblacionTextField: UITextField!
    @IBOutlet weak var ciudadTextField: UITextFieldWithPickerView!
    @IBOutlet weak var cpTextField: UITextField!
    @IBOutlet weak var telefono1TextField: UITextField!
    @IBOutlet weak var faxTextField: UITextField!
    @IBOutlet weak var telefono2TextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var cliente_id: Int = 0
    var cliente: Cliente?
    var condicionesPagoList = CondicionesPagoList()
    var tiposClientesList = TiposClientesList()
    var zonasClientesList = ZonasClientesList()
    var monedasList = MonedasList()
    var cobradoresList = CobradoresList()
    var vendedoresList = VendedoresList()
    var ciudadesList = CiudadesList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = self.firstView {
            self.firstView.hidden = false
            self.secondView.hidden = true
        }
        
        if self.cliente_id != 0 {
            self.carsButton.enabled = true
            self.loadCliente(self.cliente_id)
        } else {
            self.carsButton.enabled = false
            
            self.cliente = Cliente()
            self.cliente?.DIRECCION = Cliente.Direccion()
            
            self.cliente?.CLIENTE_ID = cliente_id
            self.cliente?.DIRECCION?.DIR_CLI_ID = 0
            self.loadStuff()
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            UIView.animateWithDuration(0.5, animations: {
                self.firstView.alpha = 1
                self.secondView.alpha = 0
                self.firstView.hidden = false
                self.secondView.hidden = true
            })
        case 1:
            UIView.animateWithDuration(0.5, animations: {
                self.firstView.alpha = 0
                self.secondView.alpha = 1
                self.firstView.hidden = true
                self.secondView.hidden = false
            })
        default:
            break;
        }
    }
    
    
    @IBAction func doneButton(sender: UIBarButtonItem) {
        self.saveCliente()
    }
    
    @IBAction func vehiclesButtonAction(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showVehiculosCliente", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detailViewController = segue.destinationViewController as? VehiculosViewController {
            detailViewController.cliente_id = (self.cliente?.CLIENTE_ID)!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadStuff() {
        dispatch_async(dispatch_get_main_queue()) {
            self.loadCondicionesPago()
            self.loadTiposClientes()
            self.loadZonasClientes()
            self.loadMonedas()
            self.loadCobradores()
            self.loadVendedores()
            self.loadCiudades()
        }
    }
    
    func loadCliente(id: Int) {
        let loadingIndicator = LoadingIndicator(text: "Cargando...")
        self.view.addSubview(loadingIndicator)
        ClientesController.mostrar(id) {(c) -> Void in
            self.cliente = c
            if let nombre = self.cliente!.NOMBRE {
                self.nombreTextField.text = nombre
            }
            if let contacto1 = self.cliente!.CONTACTO1 {
                self.contacto1TextField.text = contacto1
            }
            if let contacto2 = self.cliente!.CONTACTO2 {
                self.contacto2TextField.text = contacto2
            }
            if let rfc = self.cliente!.DIRECCION?.RFC_CURP {
                self.rfcTextField.text = rfc
            }
            if let lmite_credito = self.cliente!.LIMITE_CREDITO{
                self.limiteCreditoTextField.text = String(lmite_credito)
            }
            
            //DIRECCION
            if let calle = self.cliente!.DIRECCION?.NOMBRE_CALLE {
                self.calleTextField.text = calle
            }
            if let num_exterior = self.cliente!.DIRECCION?.NUM_EXTERIOR {
                self.noExteriorTextField.text = num_exterior
            }
            if let num_interior = self.cliente!.DIRECCION?.NUM_INTERIOR {
                self.noInteriorTextField.text = num_interior
            }
            if let colonia = self.cliente!.DIRECCION?.COLONIA {
                self.coloniaTextField.text = colonia
            }
            if let poblacion = self.cliente!.DIRECCION?.POBLACION {
                self.poblacionTextField.text = poblacion
            }
            if let cp = self.cliente!.DIRECCION?.CODIGO_POSTAL {
                self.cpTextField.text = cp
            }
            if let telefono1 = self.cliente!.DIRECCION?.TELEFONO1 {
                self.telefono1TextField.text = telefono1
            }
            if let telefono2 = self.cliente!.DIRECCION?.TELEFONO2 {
                self.telefono2TextField.text = telefono2
            }
            if let fax = self.cliente!.DIRECCION?.FAX {
                self.faxTextField.text = fax
            }
            if let email = self.cliente!.DIRECCION?.EMAIL {
                self.emailTextField.text = email
            }

            self.loadStuff()
            loadingIndicator.removeFromSuperview()
        }
    }
    
    func saveCliente() {
        let loadingIndicator = LoadingIndicator(text: "Guardando...")
        self.view.addSubview(loadingIndicator)
        
        setValuesForCliente() {(c) -> Void in
            let param: [String: AnyObject]
            let direccion: [String: AnyObject]
            
            let usuario: String = MicroNic.getUSUARIO()
            
            direccion = ["direccion_id": (self.cliente!.DIRECCION?.DIR_CLI_ID)!, "nombre_calle": (self.cliente!.DIRECCION!.NOMBRE_CALLE)!, "num_exterior": (self.cliente!.DIRECCION!.NUM_EXTERIOR)!, "num_interior": (self.cliente!.DIRECCION!.NUM_INTERIOR)!, "colonia": (self.cliente!.DIRECCION!.COLONIA)!, "poblacion": (self.cliente!.DIRECCION!.POBLACION)!, "ciudad_id": (self.cliente!.DIRECCION!.CIUDAD_ID)!, "codigo_postal": (self.cliente!.DIRECCION!.CODIGO_POSTAL)!, "telefono1": (self.cliente!.DIRECCION!.TELEFONO1)!, "telefono2": (self.cliente!.DIRECCION!.TELEFONO2)!, "fax": (self.cliente!.DIRECCION!.FAX)!, "email": (self.cliente!.DIRECCION!.EMAIL)!, "rfc_curp": (self.cliente!.DIRECCION!.RFC_CURP)!]
            
            param = ["cliente_id": (self.cliente?.CLIENTE_ID)!, "nombre": self.cliente!.NOMBRE!, "contacto1": self.cliente!.CONTACTO1!, "contacto2": self.cliente!.CONTACTO2!, "limite_credito": self.cliente!.LIMITE_CREDITO!, "moneda_id": self.cliente!.MONEDA_ID!, "cond_pago_id": self.cliente!.COND_PAGO_ID!,"tipo_cliente_id": self.cliente!.TIPO_CLIENTE_ID!,"zona_cliente_id": self.cliente!.ZONA_CLIENTE_ID!, "cobrador_id": self.cliente!.COBRADOR_ID!, "vendedor_id": self.cliente!.VENDEDOR_ID!, "usuario": usuario, "direccion": direccion]
            
            ClientesController.crear(param) {(c) -> Void in
                loadingIndicator.removeFromSuperview()
                if c {
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
            }
        }
    }
    
    func setValuesForCliente(completion: Bool -> Void) {
        self.cliente!.NOMBRE = self.nombreTextField.text
        self.cliente!.CONTACTO1 = self.contacto1TextField.text
        self.cliente!.CONTACTO2 = self.contacto2TextField.text
        self.cliente!.LIMITE_CREDITO = Double(self.limiteCreditoTextField.text!)
        
        if self.condicionesPagoList.condicionesPago.count > 0 {
            self.cliente?.COND_PAGO_ID = (self.condicionesPagoList.getItem(self.condicionesDePagoTextField.selectedRow()).COND_PAGO_ID)!
        } else {
            self.cliente?.COND_PAGO_ID = 0
        }
        if self.tiposClientesList.tiposClientes.count > 0 {
            self.cliente?.TIPO_CLIENTE_ID = (self.tiposClientesList.getItem(self.tipoClienteTextField.selectedRow()).TIPO_CLIENTE_ID)!
        } else {
            self.cliente?.TIPO_CLIENTE_ID = 0
        }
        if self.zonasClientesList.zonasClientes.count > 0 {
            self.cliente?.ZONA_CLIENTE_ID = (self.zonasClientesList.getItem(self.zonaClienteTextField.selectedRow()).ZONA_CLIENTE_ID)!
        } else {
            self.cliente?.ZONA_CLIENTE_ID = 0
        }
        if self.monedasList.monedas.count > 0 {
            self.cliente?.MONEDA_ID = (self.monedasList.getItem(self.monedaTextField.selectedRow()).MONEDA_ID)!
        } else {
            self.cliente?.MONEDA_ID = 0
        }
        if self.cobradoresList.cobradores.count > 0 {
            self.cliente?.COBRADOR_ID = (self.cobradoresList.getItem(self.cobradorTextField.selectedRow()).COBRADOR_ID)!
        } else {
            self.cliente?.COBRADOR_ID = 0
        }
        if self.vendedoresList.vendedores.count > 0 {
            self.cliente?.VENDEDOR_ID = (self.vendedoresList.getItem(self.vendedorTextField.selectedRow()).VENDEDOR_ID)!
        } else {
            self.cliente?.VENDEDOR_ID = 0
        }
        
        //DIRECCION
        self.cliente!.DIRECCION!.NOMBRE_CALLE = self.calleTextField.text
        self.cliente!.DIRECCION!.NUM_EXTERIOR = self.noExteriorTextField.text
        self.cliente!.DIRECCION!.NUM_INTERIOR = self.noInteriorTextField.text
        self.cliente!.DIRECCION!.COLONIA = self.coloniaTextField.text
        self.cliente!.DIRECCION!.POBLACION = self.poblacionTextField.text
        self.cliente!.DIRECCION!.CODIGO_POSTAL = self.cpTextField.text
        self.cliente!.DIRECCION!.TELEFONO1 = self.telefono1TextField.text
        self.cliente!.DIRECCION!.TELEFONO2 = self.telefono2TextField.text
        self.cliente!.DIRECCION!.FAX = self.faxTextField.text
        self.cliente!.DIRECCION!.EMAIL = self.emailTextField.text
        self.cliente!.DIRECCION!.RFC_CURP = self.rfcTextField.text
        
        if self.ciudadesList.ciudades.count > 0 {
            self.cliente?.DIRECCION?.CIUDAD_ID = (self.ciudadesList.getItem(self.ciudadTextField.selectedRow()).CIUDAD_ID)!
        } else {
            self.cliente?.DIRECCION?.CIUDAD_ID = 0
        }
        
        completion(true)
    }
    
    func loadCondicionesPago() {
        ComunController.condiciones_pago(self.condicionesPagoList) {(r) -> Void in
            if r {
                self.condicionesDePagoTextField.pickViewOptions = self.condicionesPagoList.condicionesPago.map({ (CondicionPago) -> String in
                    return CondicionPago.NOMBRE!
                })
                if self.condicionesPagoList.condicionesPago.count > 0 {
                    if let condicion_pago_id = self.cliente!.COND_PAGO_ID {
                        self.condicionesDePagoTextField.defaultSelectedRow(self.condicionesPagoList.condicionesPago.indexOf({$0.COND_PAGO_ID == condicion_pago_id})!)
                    } else {
                        self.condicionesDePagoTextField.defaultSelectedRow(self.condicionesPagoList.condicionesPago.indexOf({$0.ES_PREDET == "S"})!)
                    }
                }
            }
        }
    }
    
    func loadTiposClientes() {
        ComunController.tipos_clientes(self.tiposClientesList) {(r) -> Void in
            if r {
                if self.tiposClientesList.tiposClientes.count > 0 {
                    self.tipoClienteTextField.pickViewOptions = self.tiposClientesList.tiposClientes.map({ (TipoCliente) -> String in
                        return TipoCliente.NOMBRE!
                    })
                    if let tipo_cliente_id = self.cliente!.TIPO_CLIENTE_ID {
                        self.tipoClienteTextField.defaultSelectedRow(self.tiposClientesList.tiposClientes.indexOf({$0.TIPO_CLIENTE_ID == tipo_cliente_id})!)
                    } else {
                        self.tipoClienteTextField.defaultSelectedRow(self.tiposClientesList.tiposClientes.indexOf({$0.ES_PREDET == "S"})!)
                    }
                }
            }
        }
    }
    
    func loadZonasClientes() {
        ComunController.zonas_clientes(self.zonasClientesList) {(r) -> Void in
            if r {
                if self.zonasClientesList.zonasClientes.count > 0 {
                    self.zonaClienteTextField.pickViewOptions = self.zonasClientesList.zonasClientes.map({ (ZonaCliente) -> String in
                        return ZonaCliente.NOMBRE!
                    })
                    if let zona_cliente_id = self.cliente!.ZONA_CLIENTE_ID {
                        self.zonaClienteTextField.defaultSelectedRow(self.zonasClientesList.zonasClientes.indexOf({$0.ZONA_CLIENTE_ID == zona_cliente_id})!)
                    } else {
                        self.zonaClienteTextField.defaultSelectedRow(self.zonasClientesList.zonasClientes.indexOf({$0.ES_PREDET == "S"})!)
                    }
                }
            }
        }
    }
    
    func loadMonedas() {
        ComunController.monedas(self.monedasList) {(r) -> Void in
            if r {
                self.monedaTextField.pickViewOptions = self.monedasList.monedas.map({ (Moneda) -> String in
                    return Moneda.NOMBRE!
                })
                if self.monedasList.monedas.count > 0 {
                    if let moneda_id = self.cliente!.MONEDA_ID {
                        self.monedaTextField.defaultSelectedRow(self.monedasList.monedas.indexOf({$0.MONEDA_ID == moneda_id})!)
                    } else {
                        self.monedaTextField.defaultSelectedRow(self.monedasList.monedas.indexOf({$0.ES_PREDET == "S"})!)
                    }
                }
            }
        }
    }
    
    func loadCobradores() {
        ComunController.cobradores(self.cobradoresList) {(r) -> Void in
            if r {
                self.cobradorTextField.pickViewOptions = self.cobradoresList.cobradores.map({ (Cobrador) -> String in
                    return Cobrador.NOMBRE!
                })
                if self.cobradoresList.cobradores.count > 0 {
                    if let cobrador_id = self.cliente!.COBRADOR_ID {
                        self.cobradorTextField.defaultSelectedRow(self.cobradoresList.cobradores.indexOf({$0.COBRADOR_ID == cobrador_id})!)
                    } else {
                        if (self.cobradoresList.cobradores.count > 0) {
                            self.cobradorTextField.defaultSelectedRow(self.cobradoresList.cobradores.indexOf({$0.ES_PREDET == "S"})!)
                        }
                    }
                }
            }
        }
    }
    
    func loadVendedores() {
        ComunController.vendedores(self.vendedoresList) {(r) -> Void in
            if r {
                self.vendedorTextField.pickViewOptions = self.vendedoresList.vendedores.map({ (Vendedor) -> String in
                    return Vendedor.NOMBRE!
                })
                if self.vendedoresList.vendedores.count > 0 {
                    if let vendedor_id = self.cliente!.VENDEDOR_ID {
                        self.vendedorTextField.defaultSelectedRow(self.vendedoresList.vendedores.indexOf({$0.VENDEDOR_ID == vendedor_id})!)
                    } else {
                        if (self.vendedoresList.vendedores.count > 0) {
                            self.vendedorTextField.defaultSelectedRow(self.vendedoresList.vendedores.indexOf({$0.ES_PREDET == "S"})!)
                        }
                    }
                }
            }
        }
    }
    
    func loadCiudades() {
        ComunController.ciudades(self.ciudadesList) {(r) -> Void in
            if r {
                self.ciudadTextField.pickViewOptions = self.ciudadesList.ciudades.map({ (Ciudad) -> String in
                    return Ciudad.NOMBRE!
                })
                if self.ciudadesList.ciudades.count > 0 {
                    if let ciudad_id = self.cliente!.DIRECCION?.CIUDAD_ID {
                        self.ciudadTextField.defaultSelectedRow(self.ciudadesList.ciudades.indexOf({$0.CIUDAD_ID == ciudad_id})!)
                    } else {
                        self.ciudadTextField.defaultSelectedRow(self.ciudadesList.ciudades.indexOf({$0.ES_PREDET == "S"})!)
                    }
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}