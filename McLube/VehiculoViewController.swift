//
//  VehiculoViewController.swift
//  McLube
//
//  Created by Jorge Zamarrón on 19/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class VehiculoViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var serviciosButton: UIBarButtonItem!
    
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var serieTextField: UITextField!
    @IBOutlet weak var claveClienteTextField: UITextField!
    @IBOutlet weak var clienteTextField: UITextFieldWithPickerView!
    @IBOutlet weak var marcaTextField: UITextField!
    @IBOutlet weak var modeloTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var añoTextField: UITextField!
    
    var vehiculo_id: Int = 0
    var vehiculo: Vehiculo?
    let clientesList = ClientesList()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.claveClienteTextField.delegate = self
        
        if (self.vehiculo_id != 0) {
            self.serviciosButton.enabled = true
            self.loadArticulo(self.vehiculo_id)
        } else {
            self.serviciosButton.enabled = false
            self.vehiculo = Vehiculo()
            self.vehiculo?.VEHICULO_ID = 0
        }
        
        // Do any additional setup after loading the view.
    }
    
    func loadArticulo(id: Int) {
        let loadingIndicator = LoadingIndicator(text: "Cargando...")
        self.view.addSubview(loadingIndicator)
        VehiculosController.mostrar(id) {(v) -> Void in
            self.vehiculo = v
            
            if let nombre = self.vehiculo?.NOMBRE {
                self.nombreTextField.text = nombre
            }
            if let serie = self.vehiculo?.CLAVE_ARTICULO {
                self.serieTextField.text = serie
            }
            if let cliente_id = self.vehiculo?.CLIENTE_ID {
                self.loadClientes(String(cliente_id))
            }
            if let marca = self.vehiculo?.MARCA {
                self.marcaTextField.text = marca
            }
            if let modelo = self.vehiculo?.MODELO {
                self.modeloTextField.text = modelo
            }
            if let color = self.vehiculo?.COLOR {
                self.colorTextField.text = color
            }
            if let año = self.vehiculo?.AÑO {
                self.añoTextField.text = String(año)
            }
            
            loadingIndicator.removeFromSuperview()
        }
    }

    
    func loadClientes(q: String) {
        ClientesController.buscar(q, clientesList: self.clientesList) {(r) -> Void in
            if r {
                self.clienteTextField.pickViewOptions = self.clientesList.clientes.map({ (Cliente) -> String in
                    return Cliente.NOMBRE!
                })
                if (self.clientesList.clientes.count > 0) {
                    self.clienteTextField.defaultSelectedRow(0)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonAction(sender: UIBarButtonItem) {
        self.nombreTextField.text = self.marcaTextField.text! + " " + self.modeloTextField.text! + " " + self.añoTextField.text! + " " + self.colorTextField.text! + " (" + self.serieTextField.text! + ")"

        self.saveVehiculo()
    }
    
    @IBAction func serviciosButtonAction(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showVehiculoServicios", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detailViewController = segue.destinationViewController as? ServiciosViewController {
            detailViewController.vehiculo_id = (self.vehiculo_id)
        }
    }

    
    func saveVehiculo() {
        let loadingIndicator = LoadingIndicator(text: "Guardando...")
        self.view.addSubview(loadingIndicator)
        
        setValuesForVehiculo() {(c) -> Void in
            let param: [String: AnyObject]
            
            let usuario: String = MicroNic.getUSUARIO()
            
            param = ["articulo_id": (self.vehiculo?.VEHICULO_ID)!, "cliente_id": (self.vehiculo!.CLIENTE_ID)!, "nombre": (self.vehiculo!.NOMBRE)!, "clave_articulo": (self.vehiculo!.CLAVE_ARTICULO)!, "marca": (self.vehiculo!.MARCA)!, "modelo": (self.vehiculo!.MODELO)!, "ao": (self.vehiculo!.AÑO)!, "color": (self.vehiculo!.COLOR)!, "usuario": usuario]
            
            VehiculosController.crear(param) {(c) -> Void in
                loadingIndicator.removeFromSuperview()
                if c {
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
            }
        }
    }
    
    func setValuesForVehiculo(completion: Bool -> Void) {
        self.vehiculo!.NOMBRE = self.nombreTextField.text
        self.vehiculo!.CLAVE_ARTICULO = self.serieTextField.text
        self.vehiculo!.MARCA = self.marcaTextField.text
        self.vehiculo!.MODELO = self.modeloTextField.text
        self.vehiculo!.AÑO = Int(self.añoTextField.text!)
        self.vehiculo!.COLOR = self.colorTextField.text
        
        if self.clientesList.clientes.count > 0 {
            self.vehiculo?.CLIENTE_ID = (self.clientesList.getItem(self.clienteTextField.selectedRow()).CLIENTE_ID)!
        }
        
        completion(true)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.claveClienteTextField {
            self.loadClientes(textField.text!)
            return true
        }
        return false
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
