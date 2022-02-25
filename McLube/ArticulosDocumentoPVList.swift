//
//  ArticulosDocumentoPVList.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class ArticulosDocumentoPVList: NSObject {
    var articulosDocumentoPV: [DocumentoPV.Articulo] = []
    
    func getItem(index: Int) -> DocumentoPV.Articulo {
        return articulosDocumentoPV[index]
    }
}

extension ArticulosDocumentoPVList : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articulosDocumentoPV.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let articuloDocumentoPV = articulosDocumentoPV[indexPath.row]
        cell.textLabel?.text = String(articuloDocumentoPV.UNIDADES!) + "   x   " + articuloDocumentoPV.NOMBRE! + "   =   " + MicroNic.getDoubleToCurrency(articuloDocumentoPV.PRECIO!)
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            articulosDocumentoPV.removeAtIndex(indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            tableView.endUpdates()
        }
    }
}