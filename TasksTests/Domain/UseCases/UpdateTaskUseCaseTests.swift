//
//  UpdateTaskUseCaseTests.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import XCTest
@testable import Tasks

final class UpdateTaskUseCaseTests: XCTestCase {
    class MockRepository: TaskRepository {
        var updatedID: UUID?

        func getTasks() async throws -> [Todo] { [] }
        func addTask(task: Todo) async throws {}
        func updateTask(id: UUID) async throws {
            updatedID = id
        }
        func deleteTask(id: UUID) async throws {}
        func deleteAllTask() async throws {}
    }

    func testExecute_UpdatesTask() async throws {
        let mockRepo = MockRepository()
        let useCase = UpdateTaskUseCase(repository: mockRepo)

        let id = UUID()
        try await useCase.execute(id: id)

        XCTAssertEqual(mockRepo.updatedID, id)
    }
}
