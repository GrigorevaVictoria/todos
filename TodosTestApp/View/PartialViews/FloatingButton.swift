//
//  EditButton.swift
//  TodosTestApp
//
//  Created by Виктория Григорьева on 03.09.2024.
//

import SwiftUI

struct FloatingButton: View {
    @EnvironmentObject var contextHandler: ContextHandler
    
    var body: some View {
        Spacer()
        NavigationLink( destination: TodoEditView(passedTodoItem: nil, initialDate: Date()).environmentObject(contextHandler))
        {
            Text("+ New Task")
        }
        .padding(15)
        .foregroundColor(.white)
        .background(Color.accentColor)
        .cornerRadius(30)
        //.padding(30)
    }
}

#Preview {
    FloatingButton()
}
