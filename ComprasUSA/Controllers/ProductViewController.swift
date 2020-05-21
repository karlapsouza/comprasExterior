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
    let statesManager = StatesManager.shared
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfState.inputView = pickerView

    }
    
    override func viewWillAppear(_ animated: Bool) {
        statesManager.loadStates(with: context)
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
    
    
    @IBAction func addState(_ sender: Any) {
        // consultar: https://stackoverflow.com/questions/45161615/use-same-uialertcontroller-in-different-viewcontrollers
        //showAlert(with: nil)
    }
    
    
}

extension ProductViewController: UIPickerViewDelegate, UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statesManager.states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let state = statesManager.states[row]
        return state.name
    }
    
}

