//
//  ContentView.swift
//  StewartToDo
//
//  Created by Paul M Sweazey on 30.04.2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataStore: DataStore // create reference to the class instance
                                                // that was created with the initialization
                                                // of 'ContentView' in @main file
    @State private var modalType: ModalType? = nil  // an enum, where ModalType.body is some View

    var body: some View {
        NavigationView {
            List() {
                ForEach(dataStore.toDos) { toDo in
                    Button {
                        modalType = .update(toDo)
                    } label: {
                        Text(toDo.name)
                            .font(.title3)
                            .strikethrough(toDo.completed)  // conditional strikethrough
                            .foregroundColor(toDo.completed ? .green : Color(.label))   // conditional green
                    }
                }
                .onDelete(perform: dataStore.deleteToDo)
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My ToDos")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        modalType = .new
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
        .sheet(item: $modalType) { modalType in // func presents a sheet 
            modalType
            // Could have just typed…
            // .sheet(item: $modalType) { $0 }
        }
        .alert(item: $dataStore.appError) { appError in
            print("Alert is supposed to appear now…")
            return Alert( title: Text("Bummer"), message: Text(appError.error.localizedDescription) )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataStore()) // Inject an instance of the data source
                                            // into the environment, just as was done
                                            // in the @main file
    }
}
