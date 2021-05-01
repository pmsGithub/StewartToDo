//
//  ToDoFormViewModel.swift
//  StewartToDo
//
//  Created by Paul M Sweazey on 30.04.2021.
//

import Foundation

// This is where new ToDo items are created or edited, in preparation for
// adding or returning them to the 'source of truth' MODEL.
        // This is analogous to creating a new group in a line of DLReedr.
        // The new group should begin its life within the VIEWMODEL, created
        // as a class instance to be accessed 'by reference' until it can be
        // used to build a new group in the MODEL, as part of a line in the book.
class ToDoFormViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var completed: Bool = false
    var id: String? // A new ToDo will need an id, but a new one can't have an id yet; thus, ? optional
    
    var updating: Bool {    // computed property
        id != nil           // "Now we'll know if we're updating by checking if our id isn't nil"
    }
    
    var isDisabled: Bool {  //"Don't let people save toDos without an actual name"
        name.isEmpty        // This flag will be used to disable 'addToDo()' and 'updateToDo()' if the name is empty
    }
    
    init() {}       // Pass in no toDo object if we're creating a new toDo
    
    init(_ currentToDo: ToDo) {
        self.name = currentToDo.name
        self.completed = currentToDo.completed
        id = currentToDo.id
    }
}
