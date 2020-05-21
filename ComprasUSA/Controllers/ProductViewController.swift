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
    @IBOutlet weak var ivProductImage: UIImageView!
    @IBOutlet weak var btProductImage: UIButton!
    @IBOutlet weak var tfState: UITextField!
    @IBOutlet weak var tfProductPrice: UITextField!
    @IBOutlet weak var swCreditCard: UISwitch!
    @IBOutlet weak var btAddEditProduct: UIButton!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func selectImage(_ sender: Any) {
    }
    
    @IBAction func addEditProduct(_ sender: Any) {
        if product == nil {
            product = Product(context: context)
        }
        product.productName = tfProductName.text
        //product.image = ivProductImage.image
        product.state?.name = tfState.text
        product.price = Double(tfProductPrice.text!)!
        product.useCreditCard = swCreditCard.isOn
        do{
            try context.save()
        }catch{
          print(error.localizedDescription)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
