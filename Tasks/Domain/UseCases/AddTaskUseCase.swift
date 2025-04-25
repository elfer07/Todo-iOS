//
//  AddTodoUseCase.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

class AddTaskUseCase {
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func execute(task: Todo) async throws -> Void {
        try await repository.addTask(task: task)
    }
}
