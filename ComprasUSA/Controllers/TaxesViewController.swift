//
//  TaxesViewController.swift
//  ControlaImposto
//
//  Created by Karla Pires de Souza Benetti on 11/05/20.
//  Copyright © 2020 Karla Pires de Souza Benetti. All rights reserved.
//

import UIKit
import CoreData

class TaxesViewController: UIViewController {
    
    @IBOutlet weak var lbDolarResult: UILabel!
    @IBOutlet weak var lbRealResult: UILabel!
    
    var product: Product!
    var shoppingValue: Double = 0.0
    
    let config = Configuration.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbRealResult.text = String(shoppingValueInReal)
        lbDolarResult.text = String(total())
    }
 

    var shoppingValueInReal: Double {
        let dolar = config.valueDolar
        return total() * dolar
    }
    
    func stateTaxValue(shoppingValue: Double, stateTax: Double) -> Double {
        return (shoppingValue * stateTax)/100
    }
    
    
    func iofValue(shoppingValue: Double, stateTax: Double) -> Double{
        let iof = config.valueIOF
        return ((shoppingValue + stateTax) * iof)/100
    }
    
    
    func total() -> Double{
        let entityDescription = NSEntityDescription.entity(forEntityName: "Product", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entityDescription
        var productObjs = [Product]()
        do{
            try productObjs = context.fetch(request) as! [Product] }
        catch {
            print(error.localizedDescription)
        }
        
        var valueListProduct: Double = 0.0
        
        for p in productObjs {
            let stateTax = Double(p.state!.tax)
            valueListProduct += stateTaxValue(shoppingValue: p.price, stateTax: stateTax)
            if p.useCreditCard {
                valueListProduct += iofValue(shoppingValue: valueListProduct, stateTax: stateTax)
            }
        }
        return valueListProduct
    }
    

}
