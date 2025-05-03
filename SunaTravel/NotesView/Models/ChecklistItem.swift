//
//  ChecklistItem.swift
//  SunaTravel
//
//  Created by Lilia Chechina on 03.05.2025.
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
