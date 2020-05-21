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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ShoppingTableViewController: NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            case .delete:
                break
            default:
                self.tableView.reloadData()
        }
    }
}
