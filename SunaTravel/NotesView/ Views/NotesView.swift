//
//  NoteViewModel.swift
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
                .onDelete(perform: viewModel.deleteNote)
            }
            .padding(.top, -15)
            NavigationLink(
                destination: Group {
                    if let note = newNote {
                        NoteDetailView(viewModel: viewModel, note: binding(for: note))
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
                    let note = Note(title: "", text: "")
                    viewModel.notes.append(note)
                    newNote = note
                    isNavigating = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 28))
                        .padding(.top, -20)
                        .padding(.bottom, -120)
                }
            }
        }
    }
    
    private func binding(for note: Note) -> Binding<Note> {
        guard let index = viewModel.notes.firstIndex(where: { $0.id == note.id }) else {
            fatalError("Note not found")
        }
        return $viewModel.notes[index]
    }
}
