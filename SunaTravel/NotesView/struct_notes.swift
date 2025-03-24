//
//  struct_notes.swift
//  SunaTravel
//
//  Created by Lilia Chechina on 15.03.2025.
//
import Foundation

struct ChecklistItem: Identifiable, Codable {
    let id: UUID
    var text: String
    var isChecked: Bool
    
    init(id: UUID = UUID(), text: String, isChecked: Bool = false) {
        self.id = id
        self.text = text
        self.isChecked = isChecked
    }
}

struct Note: Identifiable, Codable {
    let id: UUID
    var title: String
    var text: String
    var checklist: [ChecklistItem]
    
    init(id: UUID = UUID(), title: String, text: String, checklist: [ChecklistItem] = []) {
        self.id = id
        self.title = title
        self.text = text
        self.checklist = checklist
    }
}

// Vitus option with github
//struct Note: Identifiable, Codable {
//    let id: UUID
//    var title: String
//    var text: String
//    
//    init(id: UUID = UUID(), title: String, text: String) {
//        self.id = id
//        self.title = title
//        self.text = text
//    }
//}
