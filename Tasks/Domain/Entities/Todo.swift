//
//  Todo.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import Foundation

struct Todo: Identifiable, Equatable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var dueDate: Date?
}
