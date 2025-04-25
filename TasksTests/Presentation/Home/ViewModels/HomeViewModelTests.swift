//
//  HomeViewModelTests.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import XCTest
@testable import Tasks

@MainActor
final class HomeViewModelTests: XCTestCase {
    let mockRepository = MockRepository()
    
    func testFetchTasks() async throws {
        
        let task1 = Todo(id: UUID(), title: "Test 1", isCompleted: false)
        let task2 = Todo(id: UUID(), title: "Test 2", isCompleted: true)
        let task3 = Todo(id: UUID(), title: "Test 3", isCompleted: false)
        
        mockRepository.tasks = [task1, task2, task3]
        
        let viewModel = HomeViewModel(
            getAllTasksUseCase: GetAllTasksUseCase(repository: mockRepository), addTaskUseCase: AddTaskUseCase(repository: mockRepository), deleteTaskUseCase: DeleteTaskUseCase(repository: mockRepository), updateTaskUseCase: UpdateTaskUseCase(repository: mockRepository)
        )
        
        await viewModel.fetchTasks()
        
        XCTAssertEqual(viewModel.tasks.count, 3)
        XCTAssertEqual(viewModel.tasks.first?.title, "Test 1")
    }
    
    func testAddTask() async throws {
        let mockRepository = MockRepository()
        let viewModel = HomeViewModel(
            getAllTasksUseCase: GetAllTasksUseCase(repository: mockRepository),
            addTaskUseCase: AddTaskUseCase(repository: mockRepository),
            deleteTaskUseCase: DeleteTaskUseCase(repository: mockRepository),
            updateTaskUseCase: UpdateTaskUseCase(repository: mockRepository)
        )

        let newTask = Todo(id: UUID(), title: "New Test", isCompleted: false)
        await viewModel.addTask(task: newTask)

        XCTAssertEqual(viewModel.tasks.count, 1)
        XCTAssertEqual(viewModel.tasks.first?.title, "New Test")
        XCTAssertEqual(mockRepository.addedVideos.first?.title, "New Test")
    }
    
    func testDeleteTask() async throws {
        let task = Todo(id: UUID(), title: "Test Delete", isCompleted: false)

        let mockRepository = MockRepository()
        mockRepository.tasks = [task]

        let viewModel = HomeViewModel(
            getAllTasksUseCase: GetAllTasksUseCase(repository: mockRepository),
            addTaskUseCase: AddTaskUseCase(repository: mockRepository),
            deleteTaskUseCase: DeleteTaskUseCase(repository: mockRepository),
            updateTaskUseCase: UpdateTaskUseCase(repository: mockRepository)
        )

        await viewModel.addTask(task: task)
        await viewModel.deleteTask(id: task.id)

        XCTAssertTrue(mockRepository.deleteCalled)
        XCTAssertFalse(viewModel.tasks.contains(where: { $0.id == task.id }))
    }
    
    func testUpdateTask() async throws {
        let task = Todo(id: UUID(), title: "Update Test", isCompleted: false)

        let mockRepository = MockRepository()
        mockRepository.tasks = [task]

        let viewModel = HomeViewModel(
            getAllTasksUseCase: GetAllTasksUseCase(repository: mockRepository),
            addTaskUseCase: AddTaskUseCase(repository: mockRepository),
            deleteTaskUseCase: DeleteTaskUseCase(repository: mockRepository),
            updateTaskUseCase: UpdateTaskUseCase(repository: mockRepository)
        )

        await viewModel.updateTask(id: task.id)

        XCTAssertTrue(mockRepository.updateCalled)
    }
    
    func testFetchTasksError() async throws {
        let errorRepo = MockRepositoryWithError()

        let viewModel = HomeViewModel(
            getAllTasksUseCase: GetAllTasksUseCase(repository: errorRepo),
            addTaskUseCase: AddTaskUseCase(repository: errorRepo),
            deleteTaskUseCase: DeleteTaskUseCase(repository: errorRepo),
            updateTaskUseCase: UpdateTaskUseCase(repository: errorRepo)
        )

        await viewModel.fetchTasks()

        // Esperamos un poco para que se complete el async task
        try? await Task.sleep(nanoseconds: 300_000_000)

        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.errorMessage?.contains("Error for testing.") ?? false)
    }
    
    func testAddTaskError() async throws {
        let errorRepo = MockRepositoryWithError()
        let viewModel = HomeViewModel(
            getAllTasksUseCase: GetAllTasksUseCase(repository: errorRepo),
            addTaskUseCase: AddTaskUseCase(repository: errorRepo),
            deleteTaskUseCase: DeleteTaskUseCase(repository: errorRepo),
            updateTaskUseCase: UpdateTaskUseCase(repository: errorRepo)
        )

        let task = Todo(id: UUID(), title: "Error Task", isCompleted: false)
        await viewModel.addTask(task: task)

        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.errorMessage?.contains("Error for testing.") ?? false)
    }
    
    func testUpdateTaskError() async throws {
        let errorRepo = MockRepositoryWithError()
        let viewModel = HomeViewModel(
            getAllTasksUseCase: GetAllTasksUseCase(repository: errorRepo),
            addTaskUseCase: AddTaskUseCase(repository: errorRepo),
            deleteTaskUseCase: DeleteTaskUseCase(repository: errorRepo),
            updateTaskUseCase: UpdateTaskUseCase(repository: errorRepo)
        )

        await viewModel.updateTask(id: UUID())

        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.errorMessage?.contains("Error for testing.") ?? false)
    }
    
    func testDeleteTaskError() async throws {
        let errorRepo = MockRepositoryWithError()
        let viewModel = HomeViewModel(
            getAllTasksUseCase: GetAllTasksUseCase(repository: errorRepo),
            addTaskUseCase: AddTaskUseCase(repository: errorRepo),
            deleteTaskUseCase: DeleteTaskUseCase(repository: errorRepo),
            updateTaskUseCase: UpdateTaskUseCase(repository: errorRepo)
        )

        await viewModel.deleteTask(id: UUID())

        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.errorMessage?.contains("Error for testing.") ?? false)
    }
}
