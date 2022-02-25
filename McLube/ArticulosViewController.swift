//
//  ArticulosViewController.swift
//  McLube
//
//  Created by Jorge Zamarrón on 06/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class ArticulosViewController: UIViewController, UITableViewDelegate, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let articulosList = ArticulosList()
    let lineasList = LineasArticulosList()
    
    var refreshControl = UIRefreshControl()
    var activityIndicator = UIActivityIndicatorView()
    var selectedItem: Int?
    var filteredArticulos = ArticulosList()
    var filteredLineas = LineasArticulosList()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        
        loadLineas()
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = searchController.searchBar
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.refreshControl.addTarget(self, action: #selector(ArticulosViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
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

    func loadArticulos() {
        let loadingIndicator = LoadingIndicator(text: "Cargando...")
        self.view.addSubview(loadingIndicator)
        ArticulosController.lineas_articulos(self.selectedItem! ,articulosList: self.articulosList) {(a) -> Void in
            if a {
                self.tableView.dataSource = self.articulosList
                self.tableView.reloadData()
            }
            loadingIndicator.removeFromSuperview()
        }
    }

    @IBAction func backAction(sender: UIBarButtonItem) {
        sender.enabled = false
        self.loadLineas()
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        if self.backButton.enabled {
            filteredArticulos.articulos = self.articulosList.articulos.filter { articulo in
                return articulo.NOMBRE!.lowercaseString.containsString(searchText.lowercaseString)
            }
            if filteredArticulos.articulos.count > 0 {
                tableView.dataSource = filteredArticulos
            } else {
                tableView.dataSource = articulosList
            }
        } else {
            filteredLineas.lineasArticulos = self.lineasList.lineasArticulos.filter { linea in
                return linea.NOMBRE!.lowercaseString.containsString(searchText.lowercaseString)
            }
            if filteredLineas.lineasArticulos.count > 0 {
                tableView.dataSource = filteredLineas
            } else {
                tableView.dataSource = lineasList
            }
        }
        tableView.reloadData()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        if self.backButton.enabled {
            loadArticulos()
        } else {
            loadLineas()
        }
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
        if self.backButton.enabled {
            if self.filteredArticulos.articulos.count > 0 {
                self.selectedItem = self.filteredArticulos.getItem(indexPath.row).ARTICULO_ID
            } else {
                self.selectedItem = self.articulosList.getItem(indexPath.row).ARTICULO_ID
            }
            self.searchController.active = false
            self.performSegueWithIdentifier("showArticulo", sender: self)
        } else {
            if self.filteredLineas.lineasArticulos.count > 0 {
                self.selectedItem = self.filteredLineas.getItem(indexPath.row).LINEA_ARTICULO_ID
            } else {
                self.selectedItem = self.lineasList.getItem(indexPath.row).LINEA_ARTICULO_ID
            }
            self.searchController.active = false
            self.backButton.enabled = true
            self.loadArticulos()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.searchController.active = false
        if let detailViewController = segue.destinationViewController as? ArticuloViewController {
            detailViewController.articulo_id = self.selectedItem!
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

extension ArticulosViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            if self.backButton.enabled {
                return filteredArticulos.articulos.count
            } else {
                return filteredLineas.lineasArticulos.count
            }
        }
        if self.backButton.enabled {
            return articulosList.articulos.count
        } else {
            return lineasList.lineasArticulos.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if self.backButton.enabled {
            let articulo: Articulo
            if searchController.active && searchController.searchBar.text != "" {
                articulo = filteredArticulos.articulos[indexPath.row]
            } else {
                articulo = articulosList.articulos[indexPath.row]
            }
            cell.textLabel?.text = articulo.NOMBRE
        } else {
            let linea: LineaArticulo
            if searchController.active && searchController.searchBar.text != "" {
                linea = filteredLineas.lineasArticulos[indexPath.row]
            } else {
                linea = lineasList.lineasArticulos[indexPath.row]
            }
            cell.textLabel?.text = linea.NOMBRE
        }
        return cell
    }
}
