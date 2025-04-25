//
//  TasksApp.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import SwiftUI
import SwiftData

@main
struct TasksApp: App {
    private let modelContainer: ModelContainer = {
        do {
            return try ModelContainer(for: TodoModel.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}
