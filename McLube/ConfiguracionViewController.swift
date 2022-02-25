//
//  ConfiguracionViewController.swift
//  McLube
//
//  Created by Jorge Zamarrón on 19/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class ConfiguracionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var apiTextfield: UITextField!
    @IBOutlet weak var usuarioTextField: UITextFieldWithPickerView!
    @IBOutlet weak var cajaTextField: UITextFieldWithPickerView!
    @IBOutlet weak var cajeroTextField: UITextFieldWithPickerView!
    
    let usuariosList = UsuariosList()
    let cajasList = CajasList()
    let cajerosList = CajerosList()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let api = MicroNic.getAPI() as? String {
            self.apiTextfield.text = api
        }
        
        self.apiTextfield.delegate = self
        
        self.loadUsuarios()
        self.loadCajas()
        self.loadCajeros()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonAction(sender: UIBarButtonItem) {
        let loadingIndicator = LoadingIndicator(text: "Guardando...")
        self.view.addSubview(loadingIndicator)

        MicroNic.setAPI(self.apiTextfield.text!)
        
        MicroNic.setUSUARIO(self.usuarioTextField.text!)
        
        if self.cajasList.cajas.count > 0 {
            MicroNic.setCAJA((self.cajasList.getItem(self.cajaTextField.selectedRow()).CAJA_ID)!)
        } else {
            MicroNic.setCAJA(0)
        }
        if self.cajerosList.cajeros.count > 0 {
            MicroNic.setCAJERO((self.cajerosList.getItem(self.cajeroTextField.selectedRow()).CAJERO_ID)!)
        } else {
            MicroNic.setCAJERO(0)
        }
        
        loadingIndicator.removeFromSuperview()
    }
    
    func loadUsuarios() {
        ComunController.usuarios(self.usuariosList) {(r) -> Void in
            if r {
                self.usuarioTextField.pickViewOptions = self.usuariosList.usuarios.map({ (Usuario) -> String in
                    return Usuario.NOMBRE!
                })
                if self.usuariosList.usuarios.count > 0 {
                    if let usuario = MicroNic.getUSUARIO() as? String {
                        if usuario.characters.count > 0 {
                            self.usuarioTextField.defaultSelectedRow(self.usuariosList.usuarios.indexOf({$0.NOMBRE == usuario})!)
                        }
                    } else {
                        self.usuarioTextField.defaultSelectedRow(0)
                    }
                }
            }
        }
    }
    
    func loadCajeros() {
        ComunController.cajeros(self.cajerosList) {(r) -> Void in
            if r {
                self.cajeroTextField.pickViewOptions = self.cajerosList.cajeros.map({ (Cajero) -> String in
                    return Cajero.NOMBRE!
                })
                if self.cajerosList.cajeros.count > 0 {
                    if let cajero_id = MicroNic.getCAJERO() as? Int {
                        if let id = self.cajerosList.cajeros.indexOf({$0.CAJERO_ID == cajero_id}) {
                            self.cajeroTextField.defaultSelectedRow(id)
                        }
                    } else {
                        self.cajeroTextField.defaultSelectedRow(0)
                    }
                }
            }
        }
    }
    
    func loadCajas() {
        ComunController.cajas(self.cajasList) {(r) -> Void in
            if r {
                self.cajaTextField.pickViewOptions = self.cajasList.cajas.map({ (Caja) -> String in
                    return Caja.NOMBRE!
                })
                if self.cajasList.cajas.count > 0 {
                    if let caja_id = MicroNic.getCAJA() as? Int {
                        if let id = self.cajasList.cajas.indexOf({$0.CAJA_ID == caja_id}) {
                            self.cajaTextField.defaultSelectedRow(id)
                        }
                    } else {
                        self.cajaTextField.defaultSelectedRow(0)
                    }
                }
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.apiTextfield {
            MicroNic.setAPI(self.apiTextfield.text!)
            
            self.loadUsuarios()
            self.loadCajas()
            self.loadCajeros()
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
