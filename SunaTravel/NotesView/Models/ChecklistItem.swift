//
//  ChecklistItem.swift
//  SunaTravel
//
//  Created by Lilia Chechina on 03.05.2025.
//
import Foundation
import FirebaseFirestoreSwift

struct ChecklistItem: Identifiable, Codable {
    var id: String
    var text: String
    var isChecked: Bool
    
    init(id: String = UUID().uuidString, text: String, isChecked: Bool = false) {
        self.id = id
        self.text = text
        self.isChecked = isChecked
    }
}
