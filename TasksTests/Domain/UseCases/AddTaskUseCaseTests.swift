//
//  AddTaskUseCaseTests.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import XCTest
@testable import Tasks

final class AddTaskUseCaseTests: XCTestCase {
    class MockRepository: TaskRepository {
        var addedTask: Todo?

        func getTasks() async throws -> [Todo] { [] }
        func addTask(task: Todo) async throws {
            addedTask = task
        }
        func updateTask(id: UUID) async throws {}
        func deleteTask(id: UUID) async throws {}
        func deleteAllTask() async throws {}
    }

    func testExecute_AddsTask() async throws {
        let mockRepo = MockRepository()
        let useCase = AddTaskUseCase(repository: mockRepo)

        let task = Todo(id: UUID(), title: "New Task", isCompleted: false)
        try await useCase.execute(task: task)

        XCTAssertEqual(mockRepo.addedTask?.title, "New Task")
    }
}
