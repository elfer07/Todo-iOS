//
//  TodoModel.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import SwiftData
import Foundation

@Model
final class TodoModel {
    @Attribute(.unique) var id: UUID
    var title: String
    var isCompleted: Bool
    var dueDate: Date?
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, dueDate: Date? = nil) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
    }
    
    convenience init(from todo: Todo) {
        self.init(id: todo.id, title: todo.title, isCompleted: todo.isCompleted, dueDate: todo.dueDate)
    }
    
    func toDomain() -> Todo {
        .init(
            id: id,
            title: title,
            isCompleted: isCompleted,
            dueDate: dueDate
        )
    }
}
