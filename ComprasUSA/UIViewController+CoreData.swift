//
//  UIViewController+CoreData.swift
//  ControlaImposto
//
//  Created by Karla Pires de Souza Benetti on 11/05/20.
//  Copyright © 2020 Karla Pires de Souza Benetti. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension UIViewController{
    var appDelegate: AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var context: NSManagedObjectContext{
        return appDelegate.persistentContainer.viewContext
    }
}
