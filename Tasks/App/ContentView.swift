//
//  ContentView.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        let repository = TaskRepositoryImpl(context: modelContext)
        let homeViewModel = HomeViewModel(
            getAllTasksUseCase: GetAllTasksUseCase(repository: repository),
            addTaskUseCase: AddTaskUseCase(repository: repository),
            deleteTaskUseCase: DeleteTaskUseCase(repository: repository),
            updateTaskUseCase: UpdateTaskUseCase(repository: repository)
        )
        HomeView(viewModel: homeViewModel)
    }
}

#Preview {
    ContentView()
}
