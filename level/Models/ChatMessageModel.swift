//
//  ChatMessageModel.swift
//  level
//
//  Created by Vlad on 23.06.23.
//

import Foundation

struct ChatMessageModel: Identifiable {
    
    var documentId: String { id }
    
    let id: String
    let fromId, toId, text: String
    
    init(documentId: String, data: [String: Any]) {
        self.id = documentId
        self.fromId = data[MessagesConstants.fromId] as? String ?? ""
        self.toId = data[MessagesConstants.toId] as? String ?? ""
        self.text = data[MessagesConstants.text] as? String ?? ""
    }
}
