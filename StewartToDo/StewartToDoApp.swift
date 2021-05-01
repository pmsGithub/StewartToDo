//
//  StewartToDoApp.swift
//  StewartToDo
//
//  Created by Paul M Sweazey on 30.04.2021.
//

import SwiftUI

@main
struct StewartToDoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(DataStore()) // Injects one instance of type DataStore into the environment
                                            // an observable object that monitors @Published properties
                                            // in the DataStore class object. 
        }
    }
}
