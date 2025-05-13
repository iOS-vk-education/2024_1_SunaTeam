//
//  NotesView.swift
//  SunaTravel
//
//  Created by Lilia Chechina on 03.05.2025.
//
import SwiftUI


// The screen of the list of notes(checklists)
struct NotesView: View {
    @StateObject private var viewModel = NoteViewModel()
    @State private var isNavigating = false
    @State private var newNote: Note?
    
    var body: some View {
        VStack {
            List {
                Text("My checklists")
                    .font(.system(size: 35, weight: .bold))
                    .listRowBackground(Color(.secondarySystemBackground))
                    .padding(.top, -10)
                
                ForEach($viewModel.notes) { $note in
                    NavigationLink(destination: NoteDetailView(viewModel: viewModel, note: $note)) {
                        Text(note.title)
                            .font(.headline)
                    }
                }
                .onDelete(perform: deleteNote)
            }
            .padding(.top, -15)
            NavigationLink(
                destination: Group {
//                    if let note = newNote {
//                        NoteDetailView(viewModel: viewModel, note: binding(for: note))
//                    } else {
//                        EmptyView()
//                    }
                    if let note = newNote, let binding = binding(for: note) {
                        NoteDetailView(viewModel: viewModel, note: binding)
                    } else {
                        EmptyView()
                    }
                },
                isActive: $isNavigating,
                label: { EmptyView() }
            )
            .hidden()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                     viewModel.addNote(title: "", text: "") { addedNote in
                         self.newNote = addedNote
                         self.isNavigating = true
                     }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 28))
                        .padding(.top, -20)
                        .padding(.bottom, -120)
                }
            }
        }
    }

    private func deleteNote(at offsets: IndexSet) {
        for index in offsets {
            let noteToDelete = viewModel.notes[index]
            viewModel.deleteNote(note: noteToDelete)
        }
    }
    
    private func binding(for note: Note) -> Binding<Note>? {
        guard let index = viewModel.notes.firstIndex(where: { $0.id == note.id }) else {
//            fatalError("Note not found")
            return nil
        }
        return $viewModel.notes[index]
    }
}
