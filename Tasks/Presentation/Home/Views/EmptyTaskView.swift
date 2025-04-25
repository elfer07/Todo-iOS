//
//  EmptyTaskView.swift
//  Tasks
//
//  Created by Fernando Moreno on 24/04/2025.
//

import SwiftUI

struct EmptyTaskView: View {
    var body: some View {
        VStack {
            Image(systemName: "text.page")
            Text("No todos yet")
                .font(.headline)
        }
        .foregroundColor(.secondary)
    }
}
