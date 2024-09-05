//
//  CheckBoxView.swift
//  TodosTestApp
//
//  Created by Виктория Григорьева on 04.09.2024.
//

import SwiftUI

struct CheckBoxView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: ContextHandler
    @ObservedObject var passedTodoItem: TodoItem
    
    var body: some View {
        Image(systemName: passedTodoItem.completed ? "checkmark.square.fill" : "square")
                    .foregroundColor(passedTodoItem.completed ? Color(UIColor.systemBlue) : Color.secondary)
                    .onTapGesture {
                        passedTodoItem.completed.toggle()
                        dateHolder.saveContext(viewContext)
                    }
    }
}

#Preview {
    CheckBoxView(passedTodoItem: TodoItem())
}
