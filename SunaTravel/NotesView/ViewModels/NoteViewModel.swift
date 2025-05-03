//
//  arr_notes.swift
//  SunaTravel
//
//  Created by Lilia Chechina on 15.03.2025.
//
import Foundation
import SwiftUI

class NoteViewModel: ObservableObject {
    @Published var notes: [Note] = [] {
        didSet {
            // When changing the array - we save in userdefaults
            saveNotes()
        }
    }
    
    // initialize data when creating ViewModel
    init() {
        loadNotes()
    }
    
    // MARK: - CRUD operations
    
    func addNote(title: String, text: String) {
        let newNote = Note(title: title, text: text)
        notes.append(newNote)
    }
    
    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }
    
    func saveNotes() {
        // convert notes into data
        if let encodedData = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encodedData, forKey: "savedNotes")
        }
    }
    
    func loadNotes() {
        if let savedData = UserDefaults.standard.data(forKey: "savedNotes"),
           let decodedNotes = try? JSONDecoder().decode([Note].self, from: savedData) {
            notes = decodedNotes
        }
    }
}
