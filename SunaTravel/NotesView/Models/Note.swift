//
//  Note.swift
//  SunaTravel
//
//  Created by Lilia Chechina on 03.05.2025.
//
import Foundation

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
