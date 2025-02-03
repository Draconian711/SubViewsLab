//
//  TodoView.swift
//  SubViews
//
//  Created by Kevin Bjornberg on 1/8/25.
//

import SwiftUI

struct TodoView: View {
    @StateObject var todoController = TodosController()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Text("Todos").font(.title)
                        .padding(.leading, 25)
                    Spacer()
                    NavigationLink {
                        CreateTodoView(todosController: todoController)
                    } label: {
                        Image(systemName: "plus")
                                .padding(.trailing, 25)
                                .font(.title.weight(.thin))
                    }

                }
                .padding()
                .frame(height: 40)
                
                List {
                    ForEach($todoController.sections) { $section in
                        Section(section.sectionTitle) {
                            ForEach($section.todos) { $todo in
                                TodoRowView(todo: $todo)
                            }
                            .onDelete { offsets in
                                deleteTodo(at: offsets, from: section)
                            }
                        }
                    }
                }.listStyle(.inset)
                
                NavigationLink {
                    CreateSectionView(todosSection: todoController)
                } label: {
                    Text("Add Section")
                        .foregroundColor(.white)
                        .frame(maxWidth: 300)
                        .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                        .background(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)).fill(.blue))
                }
                
                Spacer()
            }.toolbar(.hidden)
        }
    }
    
    func deleteTodo(at offsets: IndexSet, from section: TodoSection) {
        if let index = todoController.sections.firstIndex(of: section) {
            todoController.sections[index].todos.remove(atOffsets: offsets)
        }
    }
}

struct CreateTodoView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var todosController: TodosController
    @State var newTodoText = ""
    @State var selectedSection: TodoSection
    
    init(todosController: TodosController) {
        self._todosController = ObservedObject(wrappedValue: todosController)
        self._selectedSection = State(initialValue: todosController.sections[0])
    }
    
    var body: some View {
        VStack {
            Text("Create New Todo")
                .font(.largeTitle)
                .fontWeight(.thin)
                .padding(.top)
            Spacer()
            HStack {
                TextField("Todo", text: $newTodoText)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).stroke(.gray, style: StrokeStyle(lineWidth: 0.2)))
                    .padding()
                Picker("For Section", selection: $selectedSection) {
                    ForEach(todosController.sections, id: \.self) { section in
                        Text(section.sectionTitle)
                    }
                }
                .padding(.trailing)
            }
            Spacer()
            VStack {
                Button {
                    if !newTodoText.isEmpty {
                        addNewTodo(newTodoText, for: selectedSection)

                        dismiss()
                    }
                } label: {
                    Text("Create")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                        .background(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)).fill(.blue))
                }
                Button {
                    // Dismiss view
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                        .background(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)).stroke(.red))
                }
            }
            .padding()
        }
    }
    
    func addNewTodo(_ todoTitle: String, for section: TodoSection?) {
        if let sectionIndex = todosController.sections.firstIndex(where: { $0 == section }) {
            todosController.sections[sectionIndex].todos.append(ToDo(markedComplete: false, title: todoTitle))
        }
    }
}

struct CreateSectionView: View {
    @Environment(\.dismiss) var dismiss
        
        @ObservedObject var todosSection: TodosController
        @State var newSectionText = ""
        
        init(todosSection: TodosController) {
            self._todosSection = ObservedObject(wrappedValue: todosSection)
        }
        
        var body: some View {
            VStack {
                Text("Create New Section")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .padding(.top)
                Spacer()
                TextField("Section", text: $newSectionText)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).stroke(.gray, style: StrokeStyle(lineWidth: 0.2)))
                    .padding()
                Spacer()
                VStack {
                    Button {
                        if !newSectionText.isEmpty {
                            // Add new section
                            addNewSection(newSectionText)
                            // Dismiss view
                            dismiss()
                        }
                    } label: {
                        Text("Create")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                            .background(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)).fill(.blue))
                    }
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                            .background(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)).stroke(.red))
                    }
                }
                .padding()
            }
        }
        
        func addNewSection(_ sectionTitle: String) {
            todosSection.sections.append(TodoSection(sectionTitle: sectionTitle, todos: []))
        }
}

struct CreateTodoView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTodoView(todosController: TodosController())
    }
}

struct CreateSectionView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSectionView(todosSection: TodosController())
    }
}



#Preview {
    TodoView()
}
