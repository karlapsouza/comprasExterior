//
//  ShoppingTableViewController.swift
//  BrunaKarlaTatianeVictor
//
//  Created by Karla Pires de Souza Benetti on 17/05/20.
//  Copyright © 2020 Karla Pires de Souza Benetti. All rights reserved.
//

import UIKit
import CoreData

class ShoppingTableViewController: UITableViewController {
    
    var fetchedResultsController: NSFetchedResultsController<Product>!
    let label = UILabel()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Sua lista está vazia!"
        label.textAlignment = .center
        loadProducts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productSegue" {
            let vc = segue.destination as! ProductViewController
            if let products = fetchedResultsController.fetchedObjects{
                vc.product = products[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    func loadProducts(){
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let sortDescritorName = NSSortDescriptor(key: "productName", ascending: true)
        let sortDescritorPrice = NSSortDescriptor(key: "price", ascending: true)
        fetchRequest.sortDescriptors = [sortDescritorName,sortDescritorPrice]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do{
            try fetchedResultsController.performFetch()
        }catch{
            print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = fetchedResultsController.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? label : nil
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell

        guard let product = fetchedResultsController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        cell.prepare(with: product)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let product = fetchedResultsController.fetchedObjects?[indexPath.row] else {return}
            context.delete(product)
        }
    }

}

extension ShoppingTableViewController: NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            case .delete:
                if let indexPath = indexPath {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                break
            default:
                self.tableView.reloadData()
        }
    }
}
