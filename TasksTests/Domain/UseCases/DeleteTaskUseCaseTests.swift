//
//  DeleteTaskUseCaseTests.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import XCTest
@testable import Tasks

final class DeleteTaskUseCaseTests: XCTestCase {
    class MockRepository: TaskRepository {
        var deletedID: UUID?

        func getTasks() async throws -> [Todo] { [] }
        func addTask(task: Todo) async throws {}
        func updateTask(id: UUID) async throws {}
        func deleteTask(id: UUID) async throws {
            deletedID = id
        }
        func deleteAllTask() async throws {}
    }

    func testExecute_DeletesTask() async throws {
        let mockRepo = MockRepository()
        let useCase = DeleteTaskUseCase(repository: mockRepo)

        let id = UUID()
        try await useCase.execute(id: id)

        XCTAssertEqual(mockRepo.deletedID, id)
    }
}
