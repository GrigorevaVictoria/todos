//
//  Todo.swift
//  TodosTestApp
//
//  Created by Виктория Григорьева on 04.09.2024.
//

import Foundation
import CoreData

struct Todo: Codable, Identifiable {
    let id: Int
    let todo: String
    let description: String?
    let completed: Bool
    let userId: Int
    let date: Date?
}


struct ToDosResponse: Decodable {
    let todos: [Todo]
}
