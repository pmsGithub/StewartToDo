//
//  DataStore.swift
//  StewartToDo
//
//  Created by Paul M Sweazey on 30.04.2021.
//

import Foundation

class DataStore: ObservableObject {
    @Published var toDos:[ToDo] = []
    @Published var appError: ErrorType? = nil
    
    init() {
        print(FileManager.docDirURL.path)   // This prints to the console the path to the ToDo save file,
                                            //   so we can examine or modify it manually.
        if FileManager().docExist(named: fileName) {
            loadToDos()
        }
    }
    
    func addToDo(_ toDo: ToDo) {
        toDos.append(toDo)
        saveToDos()
    }
    
    func updateToDo(_ toDo: ToDo) {
        guard let index = toDos.firstIndex(where: {$0.id == toDo.id} ) else { return }
        toDos[index] = toDo
        saveToDos()
    }
    
    func deleteToDo(at indexSet: IndexSet) {
        toDos.remove(atOffsets: indexSet)
        saveToDos()
    }
    
    func loadToDos() {
//        toDos = ToDo.sampleData
        FileManager().readDocument(docName: fileName) { (result) in
            switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        toDos = try decoder.decode([ToDo].self, from: data)
                    } catch {
//                        print(ToDoError.decodingError.localizedDescription)
                        appError = ErrorType(error: ToDoError.decodingError)
                    }
                case .failure(let error):
//                    print(error.localizedDescription)
                    appError = ErrorType(error: error)
            }
        }
    }
    
    func saveToDos() {
        print("Saving toDos to filesystem")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(toDos)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: fileName) { (error) in
                if let error = error {
//                    print(error.localizedDescription)
                    appError = ErrorType(error: error)
                }
            }
        } catch {
//            print(ToDoError.encodingError.localizedDescription)
            appError = ErrorType(error: .encodingError)
        }
    }
    
}
