//
//  ProductTableViewCell.swift
//  BrunaKarlaTatianeVictor
//
//  Created by Karla Pires de Souza Benetti on 17/05/20.
//  Copyright © 2020 Karla Pires de Souza Benetti. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivProductImage: UIImageView!
    @IBOutlet weak var lbProductName: UILabel!
    @IBOutlet weak var lbProductPrice: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepare(with product: Product){
        lbProductName.text = product.productName
        lbProductPrice.text = String(product.price)
        if let image = product.image as? UIImage{
            ivProductImage.image = image
        }else{
            ivProductImage.image = UIImage(named: "placeholder-image")
        }
    }

}
