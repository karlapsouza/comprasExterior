//
//  StateViewController.swift
//  ControlaImposto
//
//  Created by Karla Pires de Souza Benetti on 11/05/20.
//  Copyright © 2020 Karla Pires de Souza Benetti. All rights reserved.
//

import UIKit

class StateViewController: UIViewController {

    @IBOutlet weak var tfStateName: UITextField!
    @IBOutlet weak var tfTax: UITextField!
    @IBOutlet weak var lbAddEditTitle: UILabel!
    @IBOutlet weak var btAddEditState: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addEditState(_ sender: Any) {
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
