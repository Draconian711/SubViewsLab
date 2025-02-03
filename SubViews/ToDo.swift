//
//  ToDo.swift
//  SubViews
//
//  Created by Kevin Bjornberg on 1/8/25.
//

import Foundation
struct ToDo: Identifiable, Hashable {
    var id: UUID = UUID()
    var markedComplete: Bool
    var title: String
}

extension ToDo {
    static var dummyTodos: [ToDo] = [
        ToDo(markedComplete: false, title: "Homework"),
        ToDo(markedComplete: true, title: "Code"),
        ToDo(markedComplete: true, title: "Sleep"),
        ToDo(markedComplete: false, title: "Learn how to collaborate using git"),
        ToDo(markedComplete: true, title: "Learn SwiftUI SubViews"),
    ]
}

struct TodoSection: Identifiable, Hashable {
    static func == (lhs: TodoSection, rhs: TodoSection) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: UUID = UUID()
    var sectionTitle: String
    var todos: [ToDo]
}

extension TodoSection {
    static var dummySections: [TodoSection] = [
        TodoSection(sectionTitle: "School", todos: [
            ToDo(markedComplete: false, title: "Homework"),
            ToDo(markedComplete: false, title: "Learn how to collaborate using git"),
            ToDo(markedComplete: true, title: "Learn SwiftUI SubViews")
        ]),
        TodoSection(sectionTitle: "Fun", todos: [
            ToDo(markedComplete: true, title: "Code"),
            ToDo(markedComplete: true, title: "Sleep")
        ])
    ]
}
