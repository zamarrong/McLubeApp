//
//  FormasCobroList.swift
//  McLube
//
//  Created by Jorge Zamarrón on 12/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class FormasCobroList: NSObject {
    var formasCobro: [FormaCobro] = []
    
    func getItem(index: Int) -> FormaCobro {
        return formasCobro[index]
    }
}

extension FormasCobroList : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formasCobro.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let formaCobro = formasCobro[indexPath.row]
        
        cell.textLabel!.text = formaCobro.NOMBRE
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            formasCobro.removeAtIndex(indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            tableView.endUpdates()
        }
    }
}