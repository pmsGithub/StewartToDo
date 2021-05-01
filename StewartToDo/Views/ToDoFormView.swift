//
//  ToDoFormView.swift
//  StewartToDo
//
//  Created by Paul M Sweazey on 30.04.2021.
//

import SwiftUI

struct ToDoFormView: View {
    @EnvironmentObject var dataStore: DataStore     // So we can update the dataStore
    @ObservedObject var formVM: ToDoFormViewModel   // "We'll inject an instance when we invoke our sheet"
    @Environment(\.presentationMode) var presentationMode   // needed to dismiss the sheet

    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading) {
                    TextField("ToDo", text: $formVM.name)
                    Toggle("Completed", isOn: $formVM.completed)
                }
            }
            .navigationTitle("ToDo")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: cancelButton, trailing: updateOrSaveButton)
        }
    }
}

extension ToDoFormView {
    func updateToDo() {
        let toDo =  // Clone an existing ToDo
            ToDo(id: formVM.id!, name: formVM.name, completed: formVM.completed)
        dataStore.updateToDo(toDo)
        presentationMode.wrappedValue.dismiss()
    }
    
    func addToDo() {
        let toDo =  // The default initializer, given the optional name, assigns a new ID
                    // and set the 'completed' property to 'false'
            ToDo(name: formVM.name)
        dataStore.addToDo(toDo)
        presentationMode.wrappedValue.dismiss()
    }
    
    // Create computed variables that return Buttons
    var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var updateOrSaveButton: some View {
        Button( formVM.updating ? "Update" : "Save",
            action: formVM.updating ? updateToDo : addToDo )
            .disabled(formVM.isDisabled)
    }
}

struct ToDoFormView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoFormView(formVM: ToDoFormViewModel())
            .environmentObject(DataStore())
    }
}
