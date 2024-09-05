//
//  NetworkManager.swift
//  TodosTestApp
//
//  Created by Виктория Григорьева on 04.09.2024.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let todosURL = "https://dummyjson.com/todos"
    private var todos: [TodoItem] = []
    
    private init() {}
    
    
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
    
}


extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

                
