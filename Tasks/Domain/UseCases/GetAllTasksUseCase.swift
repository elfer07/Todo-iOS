//
//  GetAllTodosUseCase.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

class GetAllTasksUseCase {
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Todo] {
        try await repository.getTasks()
    }
}
