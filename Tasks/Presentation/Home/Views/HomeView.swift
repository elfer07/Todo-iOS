//
//  HomeView.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Namespace private var animation

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.tasks.isEmpty {
                    EmptyTaskView()
                } else {
                    List {
                        ForEach(viewModel.tasks) { task in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(task.title)
                                        .font(.headline)
                                        .strikethrough(task.isCompleted, color: .gray)

                                    if let dueDate = task.dueDate {
                                        Text("Expiry: \(dueDate.formatted(date: .abbreviated, time: .omitted))")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }

                                Spacer()

                                if task.isCompleted {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                } else {
                                    Button {
                                        Task {
                                            await viewModel.updateTask(id: task.id)
                                        }
                                    } label: {
                                        Image(systemName: "circle")
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let task = viewModel.tasks[index]
                                Task {
                                    await viewModel.deleteTask(id: task.id)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.showAddTodo.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showAddTodo) {
                AddTaskView { newTask in
                    await viewModel.addTask(task: newTask)
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchTasks()
                }
            }
        }
    }
}
