//
//  TodoRepositoryImpl.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import SwiftData
import Foundation

final class TaskRepositoryImpl: TaskRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func getTasks() async throws -> [Todo] {
        let descriptor = FetchDescriptor<TodoModel>(
            sortBy: [.init(\.id, order: .reverse)]
        )
        let results = try context.fetch(descriptor)
        return results.map { $0.toDomain() }
    }

    func addTask(task: Todo) async throws {
        let model = TodoModel(from: task)
        context.insert(model)
        try context.save()
    }

    func updateTask(id: UUID) async throws {
        let descriptor = FetchDescriptor<TodoModel>(
            predicate: #Predicate<TodoModel> { itodo in
                itodo.id == id
            }
        )
        
        if let model = try context.fetch(descriptor).first {
            model.isCompleted.toggle()
            try context.save()
        }
    }

    func deleteTask(id: UUID) async throws {
        let descriptor = FetchDescriptor<TodoModel>(
            predicate: #Predicate<TodoModel> { todo in
                todo.id == id
            }
        )
        if let object = try context.fetch(descriptor).first {
            context.delete(object)
            try context.save()
        }
    }
}
