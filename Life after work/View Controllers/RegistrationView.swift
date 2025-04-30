//
//  RegistrationView.swift
//  Life after work
//
//  Created by Lisa J on 4/30/25.
//

import SwiftUI

struct RegistrationView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationStack {
            Form {
                Section("Registration Information") {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                    TextField("Password",text: $password)
                }
            }
            .navigationTitle("Life After Work")
            
            Button(action: register) {
                Text("Register")
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    private func register() {
        // TODO: add functionality
    }
}

#Preview {
    RegistrationView()
}
