//
//  DeleteTodoUseCase.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import Foundation

class DeleteTaskUseCase {
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func execute(id: UUID) async throws -> Void {
        try await repository.deleteTask(id: id)
    }
}
