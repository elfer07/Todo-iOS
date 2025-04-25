//
//  TodoRepository.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import Foundation

protocol TaskRepository {
    func getTasks() async throws -> [Todo]
    func addTask(task: Todo) async throws
    func updateTask(id: UUID) async throws
    func deleteTask(id: UUID) async throws
}
