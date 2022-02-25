//
//  VehiculosList.swift
//  McLube
//
//  Created by Jorge Zamarrón on 06/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class VehiculosList: NSObject {
    var vehiculos: [Vehiculo] = []
    
    func getItem(index: Int) -> Vehiculo {
        return vehiculos[index]
    }
}

extension VehiculosList : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehiculos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let vehiculo = vehiculos[indexPath.row]
        
        cell.textLabel!.text = vehiculo.NOMBRE
        //cell.detailTextLabel!.text = vehiculo.CLAVE_ARTICULO
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        tableView.endUpdates()
    }
}

