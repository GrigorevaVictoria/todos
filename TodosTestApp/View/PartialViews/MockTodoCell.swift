//
//  MockTodoCell.swift
//  TodosTestApp
//
//  Created by Виктория Григорьева on 05.09.2024.
//

import SwiftUI

struct MockTodoCell: View {
    
    let todo: Todo
    let formatter = DateFormatter()
    
    var body: some View {
        
        HStack {
                Text(todo.todo)
                    .padding(.horizontal)
                
                Image(systemName: todo.completed ? "checkmark.square.fill" : "square")
                    .foregroundColor(todo.completed ? Color(UIColor.systemBlue) : Color.secondary)
        }
    }
}


#Preview {
    MockTodoCell(todo: Todo(id: 1, todo: "Test", description: nil, completed: true, userId: 1, date: nil))
}
