//
//  ToDo.swift
//  StewartToDo
//
//  Created by Paul M Sweazey on 30.04.2021.
//

import Foundation

struct ToDo: Identifiable, Codable {
    var id: String = UUID().uuidString    // Needed for 'Identifiable' protocol
    var name: String
    var completed: Bool = false
    
    static var sampleData: [ToDo] {
        [
        ToDo(name: "Get groceries"),
        ToDo(name: "Make Dr. Appt.", completed: true)
        ]
    }
}
