//
//  ArticulosList.swift
//  McLube
//
//  Created by Jorge Zamarrón on 06/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class ArticulosList: NSObject {
    var articulos: [Articulo] = []
 
    func getItem(index: Int) -> Articulo {
        return articulos[index]
    }
}

extension ArticulosList : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articulos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let articulo = articulos[indexPath.row]
        
        cell.textLabel!.text = articulo.NOMBRE
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        articulos.removeAtIndex(indexPath.row)
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        tableView.endUpdates()
    }
}

