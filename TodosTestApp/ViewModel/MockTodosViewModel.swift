//
//  MockTodosViewModel.swift
//  TodosTestApp
//
//  Created by Виктория Григорьева on 03.09.2024.
//


import SwiftUI

@MainActor final class MockTodosViewModel: ObservableObject {
    
    @Published var todos: [Todo] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    
    func getTasks() {
        isLoading = true
    
        Task {
            do {
                todos = try await NetworkManager.shared.getTodos()
                
                
                
                isLoading = false
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
                
                isLoading = false
            }
        }
    }
}

