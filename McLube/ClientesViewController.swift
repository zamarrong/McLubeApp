//
//  ClientesViewController.swift
//  McLube
//
//  Created by Jorge Zamarrón on 06/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class ClientesViewController: UIViewController, UITableViewDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    let clientesList = ClientesList()
    
    var refreshControl = UIRefreshControl()
    var activityIndicator = UIActivityIndicatorView()
    var selectedItem: Int?
    var filteredClientes = ClientesList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = clientesList
        
        loadClientes()
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = searchController.searchBar
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.refreshControl.addTarget(self, action: #selector(ClientesViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
    }
    
    func loadClientes() {
        let loadingIndicator = LoadingIndicator(text: "Cargando...")
        self.view.addSubview(loadingIndicator)
        ClientesController.index(self.clientesList) {(c) -> Void in
            if c  {
                self.tableView.reloadData()
            }
            loadingIndicator.removeFromSuperview()
        }
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredClientes.clientes = self.clientesList.clientes.filter { cliente in
            return cliente.NOMBRE!.lowercaseString.containsString(searchText.lowercaseString)
        }
        if filteredClientes.clientes.count > 0 {
            tableView.dataSource = filteredClientes
        } else {
            tableView.dataSource = clientesList
        }
        tableView.reloadData()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        loadClientes()
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
        if self.filteredClientes.clientes.count > 0 {
            self.selectedItem = self.filteredClientes.getItem(indexPath.row).CLIENTE_ID
        } else {
            self.selectedItem = self.clientesList.getItem(indexPath.row).CLIENTE_ID
        }
        self.performSegueWithIdentifier("showCliente", sender: self)
    }
    
    @IBAction func addButton(sender: UIBarButtonItem) {
        self.selectedItem = 0
        self.performSegueWithIdentifier("showCliente", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.searchController.active = false
        if let detailViewController = segue.destinationViewController as? ClienteViewController {
            detailViewController.cliente_id = self.selectedItem!
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

extension ClientesViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredClientes.clientes.count
        }
        return clientesList.clientes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let cliente: Cliente
        if searchController.active && searchController.searchBar.text != "" {
            cliente = filteredClientes.clientes[indexPath.row]
        } else {
            cliente = clientesList.clientes[indexPath.row]
        }
        cell.textLabel?.text = cliente.NOMBRE
        return cell
    }
}