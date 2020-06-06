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
    var statesManager = StatesManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Lista de estados vazia."
        label.textAlignment = .center
        
    }
    
    func loadStates(){
        statesManager.loadStates(with: context)
        tvState.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        formatView()
        loadStates()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let count = statesManager.states.count
            tableView.backgroundView = count == 0 ? label : nil
            
            return count
       }
       
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath) as! StateTableViewCell

           let state = statesManager.states[indexPath.row]
           cell.prepare(with: state)

           return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let state = statesManager.states[indexPath.row]
            context.delete(state)
            do{
                try context.save()
                loadStates()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = statesManager.states[indexPath.row]
        showAlert(with: state)
    }
    
    
    func formatView(){
        tfDolar.text = String(config.valueDolar)
        tfTax.text = String(config.valueIOF)
    }
    
    func showAlert(with state: State?){
        let title = state == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title + " estado", message: nil, preferredStyle: .alert)
        alert.addTextField { (textFieldName) in
            textFieldName.placeholder = "Nome do estado"
            if let name = state?.name{
                textFieldName.text = name
            }
        }
        alert.addTextField { (textFieldTax) in
            textFieldTax.placeholder = "Imposto"
            if let tax = state?.tax{
                           textFieldTax.text = String(tax)
                       }
        }
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
            if alert.textFields?.first?.text == "" {
                alert.textFields?.first?.placeholder = "Nome do estado, obrigatório!"
                alert.textFields?.first?.superview!.backgroundColor = #colorLiteral(red: 1, green: 0.9137254902, blue: 0.9058823529, alpha: 1)
                alert.textFields?.last?.superview!.backgroundColor = .white
                if alert.textFields?.last?.text == "" {
                    alert.textFields?.last?.placeholder = "Imposto, obrigatório!"
                    alert.textFields?.last?.superview!.backgroundColor = #colorLiteral(red: 1, green: 0.9137254902, blue: 0.9058823529, alpha: 1)
                    alert.textFields?.last?.keyboardType = UIKeyboardType.decimalPad
                }
                self.present(alert, animated: true, completion: nil)
            }else if alert.textFields?.last?.text == "" {
                alert.textFields?.last?.placeholder = "Imposto, obrigatório!"
                alert.textFields?.last?.superview!.backgroundColor = #colorLiteral(red: 1, green: 0.9137254902, blue: 0.9058823529, alpha: 1)
                alert.textFields?.first?.superview!.backgroundColor = .white
                alert.textFields?.last?.keyboardType = UIKeyboardType.decimalPad
                self.present(alert, animated: true, completion: nil)
            }else{
                let state = state ?? State(context: self.context)
                state.name = alert.textFields?.first?.text
                state.tax = ((alert.textFields?.last?.text)! as NSString).doubleValue
                do{
                    try self.context.save()
                    self.loadStates()
                }catch{
                    print(error.localizedDescription)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
       
    }
    
    @IBAction func addState(_ sender: Any) {
        showAlert(with: nil)
    }
    
}




