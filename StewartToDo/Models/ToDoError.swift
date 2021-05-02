//
//  ToDoError.swift
//  StewartToDo
//
//  Created by Paul M Sweazey on 02.05.2021.
//

import Foundation

enum ToDoError: Error, LocalizedError {
    case saveError
    case readError
    case decodingError
    case encodingError
    
    var errorDescription: String? {
        switch self{
            
            // the 'comment:' parameters below are available to guide a translator in creating good translations for the text
            case .saveError:
                return NSLocalizedString("Could not save ToDos, please reinstall the app.", comment: "")
            case .readError:
                return NSLocalizedString("Could not save ToDos, please reinstall the app.", comment: "")
            case .decodingError:
                return NSLocalizedString("There was a problem loading your ToDos, please create a new ToDo to start over.", comment: "")
            case .encodingError:
                return NSLocalizedString("Could not save ToDos, please reinstall the app.", comment: "")
        }
    }
}

struct ErrorType: Identifiable {
    let id = UUID()
    let error: ToDoError
}
