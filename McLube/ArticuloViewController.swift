//
//  ArticuloViewController.swift
//  McLube
//
//  Created by Jorge Zamarrón on 14/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class ArticuloViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var lineaArticuloLabel: UILabel!
    @IBOutlet weak var precioLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    
    var articulo_id: Int = 0
    var articulo: Articulo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadArticulo(self.articulo_id)
        // Do any additional setup after loading the view.
    }
    
    func loadArticulo(id: Int) {
        let loadingIndicator = LoadingIndicator(text: "Cargando...")
        self.view.addSubview(loadingIndicator)
        ArticulosController.mostrar(id) {(a) -> Void in
        self.articulo = a

            self.idLabel.text = String(self.articulo_id)
            
            if let nombre = self.articulo!.NOMBRE {
                self.nombreLabel.text = nombre
            }
            if let linea_articulo = self.articulo!.LINEA_ARTICULO {
                self.lineaArticuloLabel.text = linea_articulo
            }
            if let precio = self.articulo!.PRECIO {
                self.precioLabel.text = MicroNic.getDoubleToCurrency(precio)
            }
            if let moneda = self.articulo!.MONEDA {
                self.precioLabel.text = self.precioLabel.text! + " " + moneda
            }
            if let stock = self.articulo!.STOCK {
                self.stockLabel.text = String(stock)
            }

        loadingIndicator.removeFromSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
