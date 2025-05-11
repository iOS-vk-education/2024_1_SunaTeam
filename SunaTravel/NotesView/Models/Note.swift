//
//  Note.swift
//  SunaTravel
//
//  Created by Lilia Chechina on 03.05.2025.
//
import Foundation
import FirebaseFirestoreSwift

struct Note: Identifiable, Codable {
    @DocumentID var id: String? // = nil
       var title: String
       var text: String
       var checklist: [ChecklistItem]
       
       init(id: String? = nil, title: String, text: String, checklist: [ChecklistItem] = []) {
           self.id = id
           self.title = title
           self.text = text
           self.checklist = checklist
       }
}
