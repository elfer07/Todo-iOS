//
//  GetAllTasksUseCaseTests.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import XCTest
@testable import Tasks

final class GetAllTasksUseCaseTests: XCTestCase {
    
    class MockRepository: TaskRepository {
        func getTasks() async throws -> [Todo] {
            return [
                Todo(id: UUID(), title: "Task 1", isCompleted: false),
                Todo(id: UUID(), title: "Task 2", isCompleted: true)
            ]
        }

        func addTask(task: Todo) async throws {}
        func updateTask(id: UUID) async throws {}
        func deleteTask(id: UUID) async throws {}
        func deleteAllTask() async throws {}
    }

    func testExecute_ReturnsTasks() async throws {
        let repository = MockRepository()
        let useCase = GetAllTasksUseCase(repository: repository)

        let tasks = try await useCase.execute()

        XCTAssertEqual(tasks.count, 2)
        XCTAssertEqual(tasks.first?.title, "Task 1")
    }
}
