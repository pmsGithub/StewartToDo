//
//  ModalType.swift
//  StewartToDo
//
//  Created by Paul M Sweazey on 30.04.2021.
//

import SwiftUI

// Define an enumeration of type ModalType
// which can take either
//   a value of 'new'
//   or a value of 'update' with an associated value of type ToDo
enum ModalType: Identifiable, View {
    case new
    case update(ToDo)
    var id: String {    // supporting Identifiable: a computed property that returns a string based on the case
        switch self {
            case .new:
                return "new"
            case .update:
                return "update"
        }
    }
    
    var body: some View {
        switch self {
        case .new:      // same as 'case ModalType.new'
            return ToDoFormView(formVM: ToDoFormViewModel() )
        case .update(let toDo):
            return ToDoFormView(formVM: ToDoFormViewModel(toDo) )
        }
    }
}
