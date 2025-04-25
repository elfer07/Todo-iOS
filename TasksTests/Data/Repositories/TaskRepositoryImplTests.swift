//
//  TaskRepositoryImplTests.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import SwiftData
import XCTest
@testable import Tasks

@ModelActor actor TestModelActor { }

final class TaskRepositoryImplTests: XCTestCase {
    var container: ModelContainer!
    var context: ModelContext!
    var repository: TaskRepositoryImpl!
    
    
    let task2 = Todo(id: UUID(), title: "Test task 2", isCompleted: false, dueDate: nil)
    let task3 = Todo(id: UUID(), title: "Test task 3", isCompleted: false, dueDate: nil)

    override func setUpWithError() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: TodoModel.self, configurations: config)
        context = ModelContext(container)
        repository = TaskRepositoryImpl(context: context)
    }
    
    func testAddAndGetTasks() async throws {
        let task = Todo(id: UUID(), title: "Test task 1", isCompleted: false, dueDate: nil)
        try await repository.addTask(task: task)
        
        let fetchedTasks = try await repository.getTasks()
        
        XCTAssertEqual(fetchedTasks.count, 1)
        XCTAssertEqual(fetchedTasks.first?.title, "Test task 1")
    }
    
    func testUpdateTask() async throws {
        let id = UUID()
        let task = Todo(id: id, title: "Task to update", isCompleted: false, dueDate: nil)
        try await repository.addTask(task: task)
        
        try await repository.updateTask(id: id)
        
        let tasks = try await repository.getTasks()
        XCTAssertEqual(tasks.first?.isCompleted, true)
    }
    
    func testDeleteTask() async throws {
        let id = UUID()
        let task = Todo(id: id, title: "Task to delete", isCompleted: false, dueDate: nil)
        try await repository.addTask(task: task)
        
        try await repository.deleteTask(id: id)
        
        let tasks = try await repository.getTasks()
        XCTAssertEqual(tasks.count, 0)
    }
}
