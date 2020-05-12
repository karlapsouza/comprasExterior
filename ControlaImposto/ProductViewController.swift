//
//  ProductViewController.swift
//  ControlaImposto
//
//  Created by Karla Pires de Souza Benetti on 11/05/20.
//  Copyright © 2020 Karla Pires de Souza Benetti. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet weak var tfProductName: UITextField!
    @IBOutlet weak var btProductImage: UIButton!
    @IBOutlet weak var tfState: UITextField!
    @IBOutlet weak var tfDolar: UITextField!
    @IBOutlet weak var swCreditCard: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func selectImage(_ sender: Any) {
    }
    
    @IBAction func addProduct(_ sender: Any) {
    }
    
}
