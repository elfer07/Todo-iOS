//
//  HomeViewModel.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var tasks: [Todo] = []
    @Published var showAddTodo: Bool = false
    @Published var errorMessage: String?
    
    private let getAllTasksUseCase: GetAllTasksUseCase
    private let addTaskUseCase: AddTaskUseCase
    private let deleteTaskUseCase: DeleteTaskUseCase
    private let updateTaskUseCase: UpdateTaskUseCase
    
    init(getAllTasksUseCase: GetAllTasksUseCase, addTaskUseCase: AddTaskUseCase, deleteTaskUseCase: DeleteTaskUseCase, updateTaskUseCase: UpdateTaskUseCase) {
        self.getAllTasksUseCase = getAllTasksUseCase
        self.addTaskUseCase = addTaskUseCase
        self.deleteTaskUseCase = deleteTaskUseCase
        self.updateTaskUseCase = updateTaskUseCase
    }
    
    func fetchTasks() async {
        do {
            let tasks = try await getAllTasksUseCase.execute()
            
            if !Task.isCancelled {
                self.tasks = tasks
                self.errorMessage = nil
            }
        } catch {
            if !Task.isCancelled && !(error is CancellationError) {
                self.errorMessage = "Error \(error.localizedDescription)"
            }
        }
    }
    
    
    
    func addTask(task: Todo) async {
        do {
            try await addTaskUseCase.execute(task: task)
            await MainActor.run {
                self.tasks.insert(task, at: 0)
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Error \(error.localizedDescription)"
            }
        }
    }
    
    func updateTask(id: UUID) async {
        do {
            try await updateTaskUseCase.execute(id: id)
            await fetchTasks()
        } catch {
            await MainActor.run {
                errorMessage = "Error \(error.localizedDescription)"
            }
        }
    }

    func deleteTask(id: UUID) async {
        do {
            try await deleteTaskUseCase.execute(id: id)
            await MainActor.run {
                self.tasks.removeAll { $0.id == id }
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Error \(error.localizedDescription)"
            }
        }
    }
}
