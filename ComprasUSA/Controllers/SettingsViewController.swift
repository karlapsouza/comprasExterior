//
//  SettingsViewController.swift
//  ControlaImposto
//
//  Created by Karla Pires de Souza Benetti on 11/05/20.
//  Copyright © 2020 Karla Pires de Souza Benetti. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<State>!
    let label = UILabel()
    
    @IBOutlet weak var tfDolar: UITextField!
    @IBOutlet weak var tfTax: UITextField!
    @IBOutlet weak var tvState: UITableView!
  
    let config = Configuration.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Lista de estados vazia."
        label.textAlignment = .center
        loadState()
    }
    
    func loadState(){
        let fetchRequest: NSFetchRequest<State> = State.fetchRequest()
        let sortDescritorName = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescritorName]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do{
            try fetchedResultsController.performFetch()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        formatView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let count = fetchedResultsController.fetchedObjects?.count ?? 0
            tableView.backgroundView = count == 0 ? label : nil
            return count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath) as! StateTableViewCell

           guard let state = fetchedResultsController.fetchedObjects?[indexPath.row] else {
               return cell
           }
           cell.prepare(with: state)

           return cell
       }
    
    func formatView(){
        tfDolar.text = String(config.valueDolar)
        tfTax.text = String(config.valueIOF)
    }
    
    @IBAction func addState(_ sender: Any) {
    }
    
}

extension SettingsViewController: NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            case .delete:
                break
            default:
                tvState.reloadData()
        }
    }
}
