//
//  TodosTestAppApp.swift
//  TodosTestApp
//
//  Created by Виктория Григорьева on 03.09.2024.
//

import SwiftUI

@main
struct TodosTestAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            
            let context = persistenceController.container.viewContext
            let dateHolder = ContextHandler(context)
            
            TodoListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dateHolder)
        }
    }
}
