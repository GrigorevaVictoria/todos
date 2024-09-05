//
//  TodoListViewModel.swift
//  TodosTestApp
//
//  Created by Виктория Григорьева on 05.09.2024.
//

import Foundation
import CoreData

final class TodoListViewModel: ObservableObject {
   
    
    @Published var isFirstLaunch: Bool = true
    @Published var todos: [Todo] = []
    @Published var alertItem: AlertItem?
    
//    init(viewContext: <#type#>, contextHandler: ContextHandler, isFirstLaunch: Bool, todos: [Todo], alertItem: AlertItem? = nil) {
//        self.viewContext = viewContext
//        self.contextHandler = contextHandler
//        self.isFirstLaunch = isFirstLaunch
//        self.todos = todos
//        self.alertItem = alertItem
//    }
    
    
//    @FetchRequest(entity: TodoItem.entity(), sortDescriptors: [])
//    private var items: FetchedResults<TodoItem>
    
//    private func loadTasks() {
//            DispatchQueue.global(qos: .background).async {
//                let fetchRequest: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
//                do {
//                    let todos = try viewContext.fetch(fetchRequest)
//                    DispatchQueue.main.async {
//                        
//                    }
//                } catch {
//                    print("Ошибка загрузки задач: \(error.localizedDescription)")
//                }
//            }
//        }
//    private func deleteItems(offsets: IndexSet) {
//        DispatchQueue.global(qos: .background).async {
//            withAnimation {
//                offsets.map { items[$0] }.forEach(viewContext.delete)
//            }
//            
//            DispatchQueue.main.async {
//                dateHolder.saveContext(viewContext)
//            }
//        }
//    }
//    
    
    
    private let todosURL = "https://dummyjson.com/todos"
    
    
//    private init() {}
    
    
    func getTodos() async throws ->  [Todo] {
        guard let url = URL(string: todosURL) else {
            throw TDError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
            
            do {
                let decoder = JSONDecoder()
                //decoder.userInfo[.managedObjectContext] = PersistenceController.shared.context
                //let decodedObject = try decoder.decode(ToDosResponse.self, from: data).todos
               // let decodedTodos = try decoder.decode(ToDosResponse.self, from: data).todos
//                let decodedUsers = try JSONDecoder().decode([TodoItem].self, from: data)
//                self.todos = decodedTodos
//                self.saveUsers(decodedUsers
                
                return try decoder.decode(ToDosResponse.self, from: data).todos
            } catch {
                throw TDError.invalidData
            }
        
        
    }
    func getTasks(context: NSManagedObjectContext) {
        
        Task {
            do {
//                todos = try await NetworkManager.shared.getTodos()
                todos = try await getTodos()
                saveData(context: context)
                
            } catch {
                if let tdError = error as? TDError {
                    switch tdError {
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                    case .unableComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                } else {
                    alertItem = AlertContext.invalidResponse //put generic error here
                }
            }
        }
        
        
    }
    
    func saveData(context: NSManagedObjectContext) {
        todos.forEach { (todo) in
            let item = TodoItem(context: context)
            item.id = Int32(todo.id)
            item.descriptionInfo = todo.description
            item.completed = todo.completed
            item.createdDate = .now
            item.userId = Int32(todo.userId)
            item.todo = todo.todo
        }
        
        do {
            try context.save()
        } catch {
            print("something went wrong")
        }
    }
     func checkFirstLaunch() {
        
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
                
                if !hasLaunchedBefore {
                    UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
                } else {
                    isFirstLaunch = false
                }
        }
    
}
