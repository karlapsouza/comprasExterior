//
//  Configuration.swift
//  ControlaImposto
//
//  Created by Karla Pires de Souza Benetti on 11/05/20.
//  Copyright © 2020 Karla Pires de Souza Benetti. All rights reserved.
//

import Foundation

enum UserDefaultsKeys: String {
    case valueDolar = "valueDolar"
    case valueIOF = "valueIOF"
}

class Configuration {
    
    let defaults = UserDefaults.standard
    
    static var shared: Configuration = Configuration()
    
    var valueDolar: Double{
        get{
            return defaults.double(forKey: UserDefaultsKeys.valueDolar.rawValue)
        }
        set{
           return defaults.set(newValue, forKey: UserDefaultsKeys.valueDolar.rawValue)
        }
    }
    
    var valueIOF: Double{
        get{
            return defaults.double(forKey: UserDefaultsKeys.valueIOF.rawValue)
        }
        set{
           return defaults.set(newValue, forKey: UserDefaultsKeys.valueIOF.rawValue)
        }
    }
    
    private init(){
        if defaults.double(forKey: UserDefaultsKeys.valueDolar.rawValue) == 0{
            defaults.set(5.82, forKey: UserDefaultsKeys.valueDolar.rawValue)
        }
        if defaults.double(forKey: UserDefaultsKeys.valueIOF.rawValue) == 0{
            defaults.set(6.38, forKey: UserDefaultsKeys.valueDolar.rawValue)
        }
    }
}
