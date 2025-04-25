//
//  MockRepository.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import XCTest
@testable import Tasks

class MockRepository: TaskRepository {
    var tasks: [Todo] = []
    var addedVideos: [Todo] = []
    var deleteAllCalled = false
    var deleteCalled = false
    var updateCalled = false
    
    func getTasks() async throws -> [Tasks.Todo] {
        return tasks
    }
    
    func updateTask(id: UUID) async throws {
        updateCalled = true
    }
    
    func deleteTask(id: UUID) async throws {
        deleteCalled = true
    }

    func addTask(task: Todo) async throws {
        addedVideos.append(task)
    }

    func deleteAllTask() async throws {
        deleteAllCalled = true
        tasks.removeAll()
    }
}

class MockRepositoryWithError: TaskRepository {
    func getTasks() async throws -> [Todo] {
        throw MockError.forcedError
    }

    func addTask(task: Todo) async throws {
        throw MockError.forcedError
    }

    func updateTask(id: UUID) async throws {
        throw MockError.forcedError
    }

    func deleteTask(id: UUID) async throws {
        throw MockError.forcedError
    }

    func deleteAllTask() async throws {
        throw MockError.forcedError
    }
}

enum MockError: Error, LocalizedError {
    case forcedError
    
    var errorDescription: String? {
        return "Error for testing."
    }
}
