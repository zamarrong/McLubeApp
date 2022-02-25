//
//  LineasArticulosList.swift
//  McLube
//
//  Created by Jorge Zamarrón on 06/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class LineasArticulosList: NSObject {
    var lineasArticulos: [LineaArticulo] = []
    
    func getItem(index: Int) -> LineaArticulo {
        return lineasArticulos[index]
    }
}

extension LineasArticulosList : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineasArticulos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let lineaArticulo = lineasArticulos[indexPath.row]
        
        cell.textLabel!.text = lineaArticulo.NOMBRE
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        lineasArticulos.removeAtIndex(indexPath.row)
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        tableView.endUpdates()
    }
}

