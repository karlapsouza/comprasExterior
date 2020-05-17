//
//  SettingsViewController.swift
//  ControlaImposto
//
//  Created by Karla Pires de Souza Benetti on 11/05/20.
//  Copyright © 2020 Karla Pires de Souza Benetti. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tfDolar: UITextField!
    
    @IBOutlet weak var tfTax: UITextField!
    @IBOutlet weak var tvState: UITableView!
  
    let config = Configuration.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        formatView()
    }
    
    func formatView(){
        tfDolar.text = String(config.valueDolar)
        tfTax.text = String(config.valueIOF)
    }
    
    @IBAction func addState(_ sender: Any) {
    }
    
}
