//
//  AddTaskView.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var dueDate: Date = Date()
    @State private var hasDueDate: Bool = false

    let onAdd: (Todo) async -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Title")) {
                    TextField("type your task...", text: $title)
                }

                Section {
                    Toggle("Set expiration date", isOn: $hasDueDate)
                    
                    if hasDueDate {
                        DatePicker("Expiry", selection: $dueDate, displayedComponents: .date)
                    }
                }
            }
            .navigationTitle("New task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        Task {
                            let newTask = Todo(
                                id: UUID(),
                                title: title,
                                isCompleted: false,
                                dueDate: hasDueDate ? dueDate : nil
                            )
                            await onAdd(newTask)
                            dismiss()
                        }
                    }
                    .disabled(title.isEmpty)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
