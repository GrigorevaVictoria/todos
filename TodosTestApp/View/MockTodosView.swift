//
//  MockTodosView.swift
//  TodosTestApp
//
//  Created by Виктория Григорьева on 03.09.2024.
//

import SwiftUI

struct MockTodosView: View {
    @StateObject var viewModel = TodoListViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var contextHandler: ContextHandler

    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.todos) { todo in
                    MockTodoCell(todo: todo)
                        .listRowSeparator(.hidden)
                }
                .navigationTitle("Todos")
                .listStyle(.plain)
            }
            .task {
                viewModel.getTasks(context: viewContext)
                
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    MockTodosView()
}
