//
//  ContentView.swift
//  TodosTestApp
//
//  Created by Виктория Григорьева on 03.09.2024.
//

import SwiftUI
import CoreData

struct TodoListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var contextHandler: ContextHandler

    @StateObject var viewModel = TodoListViewModel()
    
    @FetchRequest(entity: TodoItem.entity(), sortDescriptors: [])
    private var items: FetchedResults<TodoItem>
   

    var body: some View {
        if viewModel.isFirstLaunch {
            MockTodosView()
                .onAppear(perform: viewModel.checkFirstLaunch)
                .task {
                    viewModel.saveData(context: viewContext)
                    
                }
        } else {
            
            NavigationView {
                VStack {
                    //ZStack {
                        List {
                            ForEach(items) { item in
                                NavigationLink(destination: TodoEditView(passedTodoItem: item, initialDate: Date()).environmentObject(contextHandler)) {
                                    TodoCell(passedTodoItem: item).environmentObject(contextHandler)
                                }
                            }
                            .onDelete(perform: deleteItems)
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                EditButton()
                            }
                            //                ToolbarItem {
                            //                    Button(action: addItem) {
                            //                        Label("Add Item", systemImage: "plus")
                            //                    }
                            //                }
                        }
                        
                        FloatingButton().environmentObject(contextHandler)
                    //}
                }
            }
            .navigationTitle("To do list")
            .onAppear(perform: loadTasks)
        }
    }
   
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            contextHandler.saveContext(viewContext)
//        }
//    }
    
    
    
    private func loadTasks() {
            DispatchQueue.global(qos: .background).async {
                let fetchRequest: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
                do {
                    let todos = try viewContext.fetch(fetchRequest)
//                    DispatchQueue.main.async {
//
//                    }
                } catch {
                    print("Ошибка загрузки задач: \(error.localizedDescription)")
                }
            }
        }
    private func deleteItems(offsets: IndexSet) {
        DispatchQueue.global(qos: .background).async {
            withAnimation {
                offsets.map { items[$0] }.forEach(viewContext.delete)
            }
            
            DispatchQueue.main.async {
                contextHandler.saveContext(viewContext)
            }
        }
    }
}



#Preview {
    TodoListView()
}
