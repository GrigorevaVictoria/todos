//
//  TodoCell.swift
//  TodosTestApp
//
//  Created by Виктория Григорьева on 04.09.2024.
//

import SwiftUI

struct TodoCell: View {
    @EnvironmentObject var dateHolder: ContextHandler
    @ObservedObject var passedTodoItem: TodoItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(passedTodoItem.todo ?? "")
                    .padding(.leading, 10)
                    .bold()
                Text(passedTodoItem.descriptionInfo ?? "")
                    .padding(.leading, 10)
                if let date = passedTodoItem.createdDate {
                    Text("\(date, formatter: itemFormatter)")
                        .font(.subheadline)
                        .foregroundStyle(Color.secondary)
                        .padding(.leading, 10)
                }
                
            }
            .padding(5)
            .frame(width: 310, alignment: .leading)
            VStack {
                CheckBoxView(passedTodoItem: passedTodoItem).environmentObject(dateHolder)
            }
            .frame(width:30)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    TodoCell(passedTodoItem: TodoItem())
}
