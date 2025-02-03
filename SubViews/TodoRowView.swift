//
//  TodoRowView.swift
//  SubViews
//
//  Created by Kevin Bjornberg on 1/8/25.
//

import SwiftUI

struct TodoRowView: View {
    @Binding var todo: ToDo
    
    var body: some View {
        HStack {
            Button {
                todo.markedComplete.toggle()
            } label: {
                Circle().strokeBorder(.blue, lineWidth: 1).background(Circle().fill(todo.markedComplete ? .blue : .clear))
                    .frame(width: 20, height: 20)
            }
            Text(todo.title)
                .padding(.leading, 5)
            Spacer()
        }
        .padding()
        .frame(height: 40)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var todo = ToDo(markedComplete: false , title: "Ryan is bullying me")
    TodoRowView(todo: $todo)
}
