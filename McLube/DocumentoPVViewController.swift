//
//  DocumentoPVViewController.swift
//  McLube
//
//  Created by Jorge Zamarrón on 15/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class DocumentoPVViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBOutlet weak var clienteTextField: UITextField!
    @IBOutlet weak var almacenTextField: UITextFieldWithPickerView!
    @IBOutlet weak var nombreTextField: UITextFieldWithPickerView!
    @IBOutlet weak var vendedorTextField: UITextFieldWithPickerView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var serieTextField: UITextField!
    @IBOutlet weak var vehiculoTextField: UITextFieldWithPickerView!
    @IBOutlet weak var articuloTextField: UITextField!
    @IBOutlet weak var nombreArticuloTextField: UITextField!
    @IBOutlet weak var unidadesTextField: UITextField!
    @IBOutlet weak var stockTextField: UITextField!
    @IBOutlet weak var precioTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var referenciaTextField: UITextField!
    @IBOutlet weak var articulosLabel: UILabel!
    
    var documento_id: Int = 0
    var articulosPVList = ArticulosDocumentoPVList()
    var vehiculosList = VehiculosList()
    var almacenesList = AlmacenesList()
    var vendedoresList = VendedoresList()
    var clientesList = ClientesList()
    let articulosList = ArticulosList()
    let lineasList = LineasArticulosList()
    var documento: DocumentoPV?
    var articulo_puente: DocumentoPV.Articulo!
    var currentList: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        
        serieTextField.delegate = self
        clienteTextField.delegate = self
        articuloTextField.delegate = self
        unidadesTextField.delegate = self
        
        if self.documento_id != 0 {
            self.loadDocumento(self.documento_id)
            self.backButton.enabled = false
            self.addButton.enabled = true
        } else {
            self.documento = DocumentoPV()
            self.documento?.DOCTO_PV_ID = self.documento_id
            self.documento?.TIPO_DOCTO = "O"
            self.backButton.enabled = false
            self.addButton.enabled = false
            self.loadStuff()
            self.loadLineas()
        }
        
        serieTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDocumento(id: Int) {
        let loadingIndicator = LoadingIndicator(text: "Cargando...")
        self.view.addSubview(loadingIndicator)
        DocumentosPVController.mostrar(id) {(d) -> Void in
            self.documento = d
            
            if let cliente_id = self.documento!.CLIENTE_ID {
                self.loadClientes(String(cliente_id))
            }
            if let cliente = self.documento!.CLAVE_CLIENTE {
                self.clienteTextField.text = cliente
            }
            
            let total = self.documento!.IMPORTE_NETO! + self.documento!.TOTAL_IMPUESTOS!
            self.totalLabel.text = MicroNic.getDoubleToCurrency(total)
            
            if let referencia = self.documento!.PERSONA {
                self.referenciaTextField.text = referencia
            }
            
            self.loadArticulosDocumentoPV()
            self.loadStuff()
            loadingIndicator.removeFromSuperview()
        }
    }
    
    func loadArticulosDocumentoPV() {
        let loadingIndicator = LoadingIndicator(text: "Cargando partidas...")
        self.view.addSubview(loadingIndicator)
        DocumentosPVController.detalles(self.documento_id, articulosPVList: self.articulosPVList) {(a) -> Void in
            if a {
                self.tableView.dataSource = self
                self.tableView.reloadData()
                self.articulosLabel.text = "" + String(self.articulosPVList.articulosDocumentoPV.count)
            }
            loadingIndicator.removeFromSuperview()
        }
    }
    
    func loadStuff() {
        loadVendedores()
        loadAlmacenes()
    }
    
    func loadClientes(q: String) {
        ClientesController.buscar(q, clientesList: self.clientesList) {(r) -> Void in
            if r {
                self.nombreTextField.pickViewOptions = self.clientesList.clientes.map({ (Cliente) -> String in
                    return Cliente.NOMBRE!
                })
                self.nombreTextField.defaultSelectedRow(0)
            }
        }
    }
    
    func loadVehiculos(q: String) {
        let loadingIndicator = LoadingIndicator(text: "Cargando...")
        self.view.addSubview(loadingIndicator)
        VehiculosController.buscar(q, vehiculosList: self.vehiculosList) {(r) -> Void in
            if r {
                if self.vehiculosList.vehiculos.count > 0 {
                    self.vehiculoTextField.pickViewOptions = self.vehiculosList.vehiculos.map({ (Vehiculo) -> String in
                        return Vehiculo.NOMBRE!
                    })
                    self.vehiculoTextField.defaultSelectedRow(0)
                    
                    let v = self.vehiculosList.getItem(self.vehiculoTextField.selectedRow())
                    
                    self.clienteTextField.text = String(v.CLIENTE_ID!)
                    self.loadClientes(String(v.CLIENTE_ID!))
                    
                    let a = DocumentoPV.Articulo()
                    
                    a.ARTICULO_ID = v.VEHICULO_ID!
                    a.NOMBRE = v.NOMBRE!
                    a.CLAVE_ARTICULO = v.CLAVE_ARTICULO!
                    a.PRECIO_UNITARIO = 0
                    a.PRECIO_TOTAL_NETO = 0
                    a.PRECIO = 0
                    a.UNIDADES = 1
                    
                    self.articulosPVList.articulosDocumentoPV.append(a)
                } else {
                    self.view.makeToast("Vehículo no encontrado")
                    self.serieTextField.text = ""
                }
            }
        }
        loadingIndicator.removeFromSuperview()
    }

    func loadVendedores() {
        ComunController.vendedores(self.vendedoresList) {(r) -> Void in
            if r {
                self.vendedorTextField.pickViewOptions = self.vendedoresList.vendedores.map({ (Vendedor) -> String in
                    return Vendedor.NOMBRE!
                })
                if let vendedor_id = self.documento?.VENDEDOR_ID {
                    self.vendedorTextField.defaultSelectedRow(self.vendedoresList.vendedores.indexOf({$0.VENDEDOR_ID == vendedor_id})!)
                } else {
                    self.vendedorTextField.defaultSelectedRow(self.vendedoresList.vendedores.indexOf({$0.ES_PREDET == "S"})!)
                }
            }
        }
    }
    
    func loadAlmacenes() {
        ComunController.almacenes(self.almacenesList) {(r) -> Void in
            if r {
                self.almacenTextField.pickViewOptions = self.almacenesList.almacenes.map({ (Almacen) -> String in
                    return Almacen.NOMBRE!
                })
                if let almacen_id = self.documento?.ALMACEN_ID {
                    self.almacenTextField.defaultSelectedRow(self.almacenesList.almacenes.indexOf({$0.ALMACEN_ID == almacen_id})!)
                } else {
                    self.almacenTextField.defaultSelectedRow(self.almacenesList.almacenes.indexOf({$0.ES_PREDET == "S"})!)
                }
            }
        }
    }
    
    func getArticulo(id: String) {
        let loadingIndicator = LoadingIndicator(text: "Cargando...")
        self.view.addSubview(loadingIndicator)
        
        var params: String = ""
        if self.almacenesList.almacenes.count > 0 {
            params = "almacen_id=" + String((self.almacenesList.getItem(self.almacenTextField.selectedRow()).ALMACEN_ID)!)
        }
        if self.clientesList.clientes.count > 0 {
            if params.characters.count > 0 {
                params = params + "&"
            }
            params = params + "cliente_id=" + String((self.clientesList.getItem(self.nombreTextField.selectedRow()).CLIENTE_ID)!)
        }
        
        ArticulosController.mostrar_docto(id, parameters: params) {(a) -> Void in
            
            if (a.ARTICULO_ID != 0) {
                self.articulo_puente = a
                self.unidadesTextField.becomeFirstResponder()
                
                if let nombre = a.NOMBRE {
                    self.nombreArticuloTextField.text = nombre
                }
                if let stock = a.STOCK {
                    self.stockTextField.text = String(stock)
                }
                if let precio = a.PRECIO {
                    self.precioTextField.text = MicroNic.getDoubleToCurrency(precio)
                }
            } else {
                self.view.makeToast("Artículo no encontrado")
                self.articuloTextField.becomeFirstResponder()
            }
            
            loadingIndicator.removeFromSuperview()
        }
    }
    
    func putArticulo(unidades: Double) {
        if let i = self.articulosPVList.articulosDocumentoPV.indexOf({$0.ARTICULO_ID == self.articulo_puente.ARTICULO_ID}) {
            let a = articulosPVList.articulosDocumentoPV[i]
            let cantidad: Double = a.UNIDADES! + unidades
            if self.articulo_puente.STOCK >= cantidad {
                a.UNIDADES = a.UNIDADES! + unidades
            } else {
                self.view.makeToast("Sin stock")
            }
        } else {
            articulo_puente.UNIDADES = unidades
            articulo_puente.PRECIO_TOTAL_NETO = unidades * articulo_puente.PRECIO_UNITARIO!
            self.articulosPVList.articulosDocumentoPV.append(articulo_puente)
        }
        
        calculaTotales()
        
        self.backButton.enabled = false
        self.addButton.enabled = true
        
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    func calculaTotales() {
        var importe_neto: Double = 0
        var total_impuestos: Double = 0
        for (_, element) in self.articulosPVList.articulosDocumentoPV.enumerate() {
            importe_neto = importe_neto + (element.PRECIO_UNITARIO! * element.UNIDADES!)
            total_impuestos = total_impuestos + ((element.PRECIO!) * element.UNIDADES!)
        }
        self.documento?.IMPORTE_NETO = importe_neto
        self.documento?.TOTAL_IMPUESTOS = total_impuestos - importe_neto
        self.totalLabel.text = MicroNic.getDoubleToCurrency(total_impuestos)
    
        self.articulosLabel.text = "" + String(self.articulosPVList.articulosDocumentoPV.count)
    }
    
    func setValuesForDocumento(completion: Bool -> Void) {
        
        if self.clientesList.clientes.count > 0 {
            self.documento!.CLIENTE_ID = (self.clientesList.getItem(self.nombreTextField.selectedRow()).CLIENTE_ID)!
            //self.documento!.DIR_CLI_ID = (self.clientesList.getItem(self.nombreTextField.selectedRow()).DIRECCION?.DIR_CLI_ID)!
        }
        if self.almacenesList.almacenes.count > 0 {
            self.documento!.ALMACEN_ID = (self.almacenesList.getItem(self.almacenTextField.selectedRow()).ALMACEN_ID)!
        }
        if self.vendedoresList.vendedores.count > 0 {
            self.documento!.VENDEDOR_ID = (self.vendedoresList.getItem(self.vendedorTextField.selectedRow()).VENDEDOR_ID)!
        }
        
        self.documento?.CAJA_ID = MicroNic.getCAJA()
        self.documento?.CAJERO_ID = MicroNic.getCAJERO()
        self.documento?.TIPO_DSCTO = "P"
        self.documento?.DSCTO_PCTJE = 0
        self.documento?.DSCTO_IMPORTE = 0
        self.documento?.USUARIO = MicroNic.getUSUARIO()
        self.documento?.ESTATUS = "P"
        self.documento?.PERSONA = self.referenciaTextField.text
        
        completion(true)
    }
    
    func saveDocumento() {
        let loadingIndicator = LoadingIndicator(text: "Guardando...")
        self.view.addSubview(loadingIndicator)
        
        setValuesForDocumento(){(c) -> Void in
            let param: [String: AnyObject]
            
            var articulos: [JSON] = []
            
            for (_, element) in self.articulosPVList.articulosDocumentoPV.enumerate() {
                let articulo: JSON = ["clave_articulo": element.CLAVE_ARTICULO!, "articulo_id": element.ARTICULO_ID!, "unidades": element.UNIDADES!, "precio_unitario": element.PRECIO_UNITARIO!, "precio_unitario_impto": element.PRECIO!, "precio_total_neto": element.PRECIO! * element.UNIDADES!]
                articulos.append(articulo)
            }
            
            param = ["docto_pv_id": (self.documento?.DOCTO_PV_ID!)!, "caja_id": (self.documento!.CAJA_ID)!, "tipo_documento": (self.documento!.TIPO_DOCTO)!, "cajero_id": (self.documento!.CAJERO_ID)!, "cliente_id": (self.documento!.CLIENTE_ID)!, "almacen_id": (self.documento!.ALMACEN_ID)!, "tipo_dscto": (self.documento!.TIPO_DSCTO)!, "dscto_pctje": (self.documento!.DSCTO_PCTJE)!, "dscto_importe": (self.documento!.DSCTO_IMPORTE)!, "importe_neto": (self.documento!.IMPORTE_NETO)!, "total_impuestos": (self.documento!.TOTAL_IMPUESTOS)!, "estatus": (self.documento!.ESTATUS)!, "persona": (self.documento!.PERSONA)!, "vendedor_id": (self.documento!.VENDEDOR_ID)!, "usuario": (self.documento!.USUARIO)!, "articulos": articulos.description.utf8.description]

            DocumentosPVController.crear(param) {(c) -> Void in
                loadingIndicator.removeFromSuperview()
                if c {
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
            }
        }
    }
    
    @IBAction func doneButton(sender: UIBarButtonItem) {
        if self.articulosPVList.articulosDocumentoPV.count > 0 {
            self.setValuesForDocumento() {(c) -> Void in
                self.saveDocumento()
            }
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.serieTextField {
            self.loadVehiculos(textField.text!)
            return true
        } else if textField == self.clienteTextField {
            self.loadClientes(textField.text!)
            return true
        } else if textField == self.articuloTextField {
            self.getArticulo(textField.text!)
            return true
        } else if textField == self.unidadesTextField {
            if Double(textField.text!) <= self.articulo_puente?.STOCK {
                self.putArticulo(Double(textField.text!)!)
                self.articuloTextField.text = ""
                self.unidadesTextField.text = ""
                self.nombreArticuloTextField.text = ""
                self.stockTextField.text = ""
                self.precioTextField.text = ""
                self.articuloTextField.becomeFirstResponder()
                return true
            } else {
                self.view.makeToast("Sin stock")
                textField.text = ""
                return false
            }
        }
        return false
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.articuloTextField {
            textField.text = ""
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.backButton.enabled {
            self.addButton.enabled = false
            self.backButton.enabled = true
            self.getArticulo(String(self.articulosList.getItem(indexPath.row).ARTICULO_ID!))
        } else if self.backButton.enabled == false && self.addButton.enabled == false {
            self.backButton.enabled = true
            self.loadArticulos(self.lineasList.getItem(indexPath.row).LINEA_ARTICULO_ID!)
        }
    }
    
    func loadLineas() {
        let loadingIndicator = LoadingIndicator(text: "Cargando...")
        self.view.addSubview(loadingIndicator)
        ArticulosController.lineas(self.lineasList) {(a) -> Void in
            if a {
                self.tableView.dataSource = self.lineasList
                self.tableView.reloadData()
            }
            loadingIndicator.removeFromSuperview()
        }
    }
    
    func loadArticulos(id: Int) {
        let loadingIndicator = LoadingIndicator(text: "Cargando...")
        self.view.addSubview(loadingIndicator)
        ArticulosController.lineas_articulos(id ,articulosList: self.articulosList) {(a) -> Void in
            if a {
                self.tableView.dataSource = self.articulosList
                self.tableView.reloadData()
            }
            loadingIndicator.removeFromSuperview()
        }
    }

    @IBAction func backButtonAction(sender: UIBarButtonItem) {
        sender.enabled = false
        self.loadLineas()
    }
    
    @IBAction func addButtonAction(sender: UIBarButtonItem) {
        sender.enabled = false
        self.backButton.enabled = false
        self.loadLineas()
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
extension DocumentoPVViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.backButton.enabled && self.addButton.enabled == false {
            return articulosList.articulos.count
        } else if self.backButton.enabled == false && self.addButton.enabled == false {
            return lineasList.lineasArticulos.count
        } else {
            return self.articulosPVList.articulosDocumentoPV.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    
        if self.backButton.enabled && self.addButton.enabled == false {
            let articulo: Articulo
            articulo = articulosList.articulos[indexPath.row]
            cell.textLabel?.text = articulo.NOMBRE
        } else if self.backButton.enabled == false && self.addButton.enabled == false {
            let linea: LineaArticulo
            linea = lineasList.lineasArticulos[indexPath.row]
            cell.textLabel?.text = linea.NOMBRE
        } else {
            let articuloDocumentoPV = self.articulosPVList.articulosDocumentoPV[indexPath.row]
            cell.textLabel?.text = String(articuloDocumentoPV.UNIDADES!) + "   x   " + articuloDocumentoPV.NOMBRE! + "   =   " + MicroNic.getDoubleToCurrency(articuloDocumentoPV.UNIDADES! * articuloDocumentoPV.PRECIO!)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.articulosPVList.articulosDocumentoPV.removeAtIndex(indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            self.calculaTotales()
            tableView.endUpdates()
        }
    }
}
