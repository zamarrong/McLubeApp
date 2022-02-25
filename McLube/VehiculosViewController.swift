//
//  VehiculosViewController.swift
//  McLube
//
//  Created by Jorge Zamarrón on 19/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class VehiculosViewController: UIViewController, UITableViewDelegate, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    let vehiculosList = VehiculosList()
    
    var refreshControl = UIRefreshControl()
    var activityIndicator = UIActivityIndicatorView()
    var cliente_id: Int = 0
    var selectedItem: Int?
    var filteredVehiculos = VehiculosList()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = vehiculosList
        
        if self.cliente_id == 0 {
            loadVehiculos()
        } else {
            loadVehiculosCliente(self.cliente_id)
        }
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = searchController.searchBar
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.refreshControl.addTarget(self, action: #selector(VehiculosViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
    }

    func loadVehiculos() {
        let loadingIndicator = LoadingIndicator(text: "Cargando...")
        self.view.addSubview(loadingIndicator)
        VehiculosController.index(self.vehiculosList) {(c) -> Void in
            if c  {
                self.tableView.reloadData()
            }
            loadingIndicator.removeFromSuperview()
        }
    }
    
    func loadVehiculosCliente(id: Int) {
        let loadingIndicator = LoadingIndicator(text: "Cargando...")
        self.view.addSubview(loadingIndicator)
        VehiculosController.cliente(id, vehiculosList: self.vehiculosList) {(c) -> Void in
            if c  {
                self.tableView.reloadData()
            }
            loadingIndicator.removeFromSuperview()
        }
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredVehiculos.vehiculos = self.vehiculosList.vehiculos.filter { vehiculo in
            return vehiculo.NOMBRE!.lowercaseString.containsString(searchText.lowercaseString) || vehiculo.CLAVE_ARTICULO!.lowercaseString.containsString(searchText.lowercaseString)
        }
        if filteredVehiculos.vehiculos.count > 0 {
            tableView.dataSource = filteredVehiculos
        } else {
            tableView.dataSource = vehiculosList
        }
        tableView.reloadData()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        loadVehiculos()
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
        if self.filteredVehiculos.vehiculos.count > 0 {
            self.selectedItem = self.filteredVehiculos.getItem(indexPath.row).VEHICULO_ID
        } else {
            self.selectedItem = self.vehiculosList.getItem(indexPath.row).VEHICULO_ID
        }
        self.performSegueWithIdentifier("showVehiculo", sender: self)
    }
    
    @IBAction func addButton(sender: UIBarButtonItem) {
        self.selectedItem = 0
        self.performSegueWithIdentifier("showVehiculo", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.searchController.active = false
        if let detailViewController = segue.destinationViewController as? VehiculoViewController {
            detailViewController.vehiculo_id = self.selectedItem!
        }
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
extension VehiculosViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredVehiculos.vehiculos.count
        }
        return vehiculosList.vehiculos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let vehiculo: Vehiculo
        if searchController.active && searchController.searchBar.text != "" {
            vehiculo = filteredVehiculos.vehiculos[indexPath.row]
        } else {
            vehiculo = vehiculosList.vehiculos[indexPath.row]
        }
        cell.textLabel?.text = vehiculo.NOMBRE
        return cell
    }
}
