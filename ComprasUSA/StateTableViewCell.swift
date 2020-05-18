//
//  StateTableViewCell.swift
//  BrunaKarlaTatianeVictor
//
//  Created by Karla Pires de Souza Benetti on 17/05/20.
//  Copyright © 2020 Karla Pires de Souza Benetti. All rights reserved.
//

import UIKit

class StateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbStateName: UILabel!
    @IBOutlet weak var lbStateTax: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func prepare(with state: State){
        lbStateName.text = state.name ?? ""
        lbStateTax.text = String(state.tax)
    }

}
