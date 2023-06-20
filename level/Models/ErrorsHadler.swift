//
//  ErrorsHadler.swift
//  level
//
//  Created by Владислав Мазуров on 20.06.23.
//

import Foundation

enum ApplicationErrors {
    case emptyFields
    case passwordsDontMatch
    
    var errorText: String {
        switch self {
        case .emptyFields:
            return "Check all fields fill correctly"
        case .passwordsDontMatch:
            return "Passwords dont match"
        }
    }
}
