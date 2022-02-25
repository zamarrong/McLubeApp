//
//  ServiciosViewController.swift
//  McLube
//
//  Created by Jorge Zamarrón on 07/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class ServiciosViewController: UIViewController, UITableViewDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let documentosList = DocumentosPVList()
    
    var refreshControl = UIRefreshControl()
    var activityIndicator = UIActivityIndicatorView()
    var selectedItem: Int?
    var vehiculo_id = 0
    var filteredDocumentos = DocumentosPVList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        
        loadDocumentos()
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = searchController.searchBar
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.refreshControl.addTarget(self, action: #selector(ServiciosViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    func loadDocumentos() {
        let loadingIndicator = LoadingIndicator(text: "Cargando...")
        self.view.addSubview(loadingIndicator)
        VehiculosController.servicios(self.vehiculo_id,documentosPVList: self.documentosList) {(a) -> Void in
            if a {
                self.tableView.dataSource = self.documentosList
                self.tableView.delegate = self
                self.tableView.reloadData()
            }
            loadingIndicator.removeFromSuperview()
        }
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredDocumentos.documentosPV = self.documentosList.documentosPV.filter { documento in
            return documento.FOLIO!.lowercaseString.containsString(searchText.lowercaseString) || documento.PERSONA!.lowercaseString.containsString(searchText.lowercaseString)
        }
        if filteredDocumentos.documentosPV.count > 0 {
            tableView.dataSource = filteredDocumentos
        } else {
            tableView.dataSource = documentosList
        }
        tableView.reloadData()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        loadDocumentos()
        refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.filteredDocumentos.documentosPV.count > 0 {
            self.selectedItem = self.filteredDocumentos.getItem(indexPath.row).DOCTO_PV_ID
        } else {
            self.selectedItem = self.documentosList.getItem(indexPath.row).DOCTO_PV_ID
        }
        self.performSegueWithIdentifier("showDocumentoPVfromServicio", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.searchController.active = false
        if let detailViewController = segue.destinationViewController as? DocumentoPVViewController {
            detailViewController.documento_id = self.selectedItem!
        }
    }
    
    // MARK: - ENSideServicios Delegate
}

extension ServiciosViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredDocumentos.documentosPV.count
        }
        return documentosList.documentosPV.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let documento: DocumentoPV
        if searchController.active && searchController.searchBar.text != "" {
            documento = filteredDocumentos.documentosPV[indexPath.row]
        } else {
            documento = documentosList.documentosPV[indexPath.row]
        }
        cell.textLabel?.text = MicroNic.getNSDateToString(documento.FECHA!) + "  " + documento.FOLIO! + "   " + documento.PERSONA!
        return cell
    }
}