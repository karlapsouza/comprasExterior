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
    var state: State!
    let statesManager = StatesManager.shared
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool){
        super .viewWillAppear(animated)
        
        if(product != nil) {
            title = "Editar produto"
            btAddEditProduct.setTitle("ALTERAR", for: .normal)
            tfProductName.text = product.productName
            if let image = product.image as? UIImage {
                ivProductImage.image = image
            }else{
                ivProductImage.image = UIImage(named: "placeholder-image")
            }
            if btProductImage != nil{
                btProductImage.setTitle(nil, for: .normal)
            }
            if let state = product.state, let index = statesManager.states.firstIndex(of: state) {
                tfState.text = state.name
                pickerView.selectRow(index, inComponent: 0, animated: true)
            }
            tfProductPrice.text = String(product.price)
            swCreditCard.isOn = product.useCreditCard
        }
        statesManager.loadStates(with: context)
        prepareStateTextField()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func cancel() {
        tfState.resignFirstResponder()
    }
    
    @objc func done() {
        tfState.text = statesManager.states[pickerView.selectedRow(inComponent: 0)].name
        cancel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productSegue" || segue.identifier == "addProductSegue" {
            let vc = segue.destination as! ProductViewController
            vc.product = product
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
    }
    
    func prepareStateTextField(){
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [btCancel, btFlexibleSpace, btDone]
        
        tfState.inputView = pickerView
        tfState.inputAccessoryView = toolbar
        
    }

    
    @IBAction func selectImage(_ sender: Any) {
        
        let alert = UIAlertController(title: "Selecionar imagem", message: "De onde gostaria de selecionar a imagem?", preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Câmera", style: .default, handler:  { (action: UIAlertAction) in
                self.selectPicture(sourceType: .camera)
            })
            alert.addAction(cameraAction)
        }
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default, handler: {(action: UIAlertAction) in
            self.selectPicture(sourceType: .photoLibrary)
        })
        alert.addAction(libraryAction)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert,animated: true,completion: nil)
        
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func validadeFields() -> Bool{
        var tf = true
        if tfProductName.text == "" {
            tfProductName.placeholder = "Nome do produto, campo obrigatório!"
            tf = false
        }
        if tfState.text == "" {
            tfState.placeholder = "Estado da compra, campo obrigatório!"
            tf = false
        }
        if tfProductPrice.text == "" {
            tfProductPrice.placeholder = "Valor (U$), campo obrigatório!"
            tf = false
        }
        return tf
    }
    
    @IBAction func addEditProduct(_ sender: Any) {
        if validadeFields(){
            if product == nil {
                product = Product(context: context)
            }
            product.productName = tfProductName.text
            let state = statesManager.states[pickerView.selectedRow(inComponent: 0)]
            product.state = state
            product.image = ivProductImage.image
            product.price = Double(tfProductPrice.text!)!
            product.useCreditCard = swCreditCard.isOn
            do{
                try context.save()
            }catch{
              print(error.localizedDescription)
            }
            navigationController?.popViewController(animated: true)
        }

    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addState(_ sender: Any) {

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

extension ProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        ivProductImage.image = image
        btProductImage.setTitle(nil, for: .normal)
        dismiss(animated: true, completion: nil)
    }
}


