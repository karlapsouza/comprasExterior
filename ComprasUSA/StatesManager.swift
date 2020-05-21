//
//  StatesManager.swift
//  BrunaKarlaTatianeVictor
//
//  Created by Karla Pires de Souza Benetti on 21/05/20.
//  Copyright © 2020 Karla Pires de Souza Benetti. All rights reserved.
//

import Foundation
import CoreData

class StatesManager {
    static let shared = StatesManager()
    var states: [State] = []
    
    func loadStates(with context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<State> = State.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do{
            states = try context.fetch(fetchRequest)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func deleteState(index: Int, context: NSManagedObjectContext){
        let state = states[index]
        context.delete(state)
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    
    private init() {
        
    }
}
