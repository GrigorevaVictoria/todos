//
//  TodoEditView.swift
//  TodosTestApp
//
//  Created by Виктория Григорьева on 03.09.2024.
//

import SwiftUI

struct TodoEditView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var contextHandler: ContextHandler
    
    @State var selectedTodoItem: TodoItem?
    @State var name: String
    @State var descriptionInfo: String
    @State var createdDate: Date
    @State var completed: Bool
    
    init(passedTodoItem: TodoItem?, initialDate: Date) {
        
        if let todoItem = passedTodoItem {
            _selectedTodoItem = State(initialValue: todoItem)
            _name = State(initialValue: todoItem.todo ?? "")
            _descriptionInfo = State(initialValue: todoItem.descriptionInfo ?? "")
            _createdDate = State(initialValue: todoItem.createdDate ?? initialDate)
            _completed = State(initialValue: todoItem.completed)
        } else {
            _name = State(initialValue: "")
            _descriptionInfo = State(initialValue: "")
            _createdDate = State(initialValue: initialDate)
            _completed = State(initialValue: false)
        }
    }
    var body: some View {
        
        Form {
            Section(header: Text("Task")) {
                TextField("Enter the task name...", text: $name)
                TextField("Enter the description...", text: $descriptionInfo)
            }
            
            Section() {
                Button("Save", action: saveAction)
                    .font(.headline)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
            }
        }
    }
    

    func saveAction() {
        DispatchQueue.global(qos: .background).async {
            withAnimation {
                if selectedTodoItem == nil {
                    selectedTodoItem = TodoItem(context: viewContext)
                }
            }
            
            selectedTodoItem?.createdDate = .now
            selectedTodoItem?.todo = name
            selectedTodoItem?.descriptionInfo = descriptionInfo
            selectedTodoItem?.completed = false
            contextHandler.saveContext(viewContext)
            
            DispatchQueue.main.async {
                //dateHolder.saveContext(viewContext)
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    TodoEditView(passedTodoItem: TodoItem(), initialDate: Date())
}
