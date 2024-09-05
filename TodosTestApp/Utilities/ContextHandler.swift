//
//  DateHolder.swift
//  TodosTestApp
//
//  Created by Виктория Григорьева on 03.09.2024.
//

import SwiftUI
import CoreData

class ContextHandler: ObservableObject {
    
    init(_ context: NSManagedObjectContext) {
        
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
            
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}
