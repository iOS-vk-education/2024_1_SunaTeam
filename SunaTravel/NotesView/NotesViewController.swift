//
//  NotesViewController.swift
//  SunaTravel
//
//  Created by Lilia Chechina on 12.03.2025.
//
import SwiftUI


// View of editing single note (check-list)
struct NoteDetailView: View {
    @State private var newItemText: String = ""
    @ObservedObject var viewModel: NoteViewModel
    @Binding var note: Note
    @FocusState private var isTitleFocused: Bool
    @Environment(\.dismiss) private var dismiss  // To return to the previous screen
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
                TextField("Enter title", text: $note.title)
                    .font(.title)
                    .focused($isTitleFocused)
//                    .padding(.leading, -2)
//                    .padding(8)
                    .cornerRadius(8)
                    .background(Color(.systemBackground))
                
                List {
                    ForEach(note.checklist) { item in
                        HStack {
                            Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                                .onTapGesture {
                                    toggleItem(item)
                                }
                            Text(item.text)
                                .strikethrough(item.isChecked)
                                .foregroundColor(item.isChecked ? .gray : .primary)
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                    .onDelete(perform: deleteItem)
                    HStack {
                        Image(systemName: "circle") // checkbox for new element
                        TextField("New item", text: $newItemText, onCommit: addItem)
                                .padding(8) // The width of the field
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(8)
                                .onSubmit {
                                    addItem()
                                    newItemText = ""
                                }
                    }
                }
                }
                .listStyle(PlainListStyle())
//                .frame(height: geometry.size.height - 150)
//                .frame(maxHeight: .infinity)  // so that less space on the screen occupies, but isn't working
                .onAppear {
                    isTitleFocused = true
                }
                .padding()
                .background(Color(.systemBackground))
                .edgesIgnoringSafeArea(.all)
                //            .navigationTitle("Edit Note")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            deleteNote()
                        }) {
                            Image(systemName: "trash.fill")
                                .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))  // later, change to color from Assets.xcassets
                                .font(.system(size: 18))
                        }
                    }
                }
                .padding()
            }
        }
    

    
    private func toggleItem(_ item: ChecklistItem) {
        if let index = note.checklist.firstIndex(where: { $0.id == item.id }) {
            note.checklist[index].isChecked.toggle()
            updateNote()
        }
    }
    
    private func addItem() {
        // MARK: Костыль
        guard !newItemText.isEmpty else { return }
        
        // We check if there is already an element with the same text
        if !note.checklist.contains(where: { $0.text == newItemText }) {
            let newItem = ChecklistItem(text: newItemText)
            print("Добавляем: \(newItem.text), ID: \(newItem.id)")
            
            note.checklist.append(newItem)
        } else {
            print("Элемент уже существует: \(newItemText)")
        }
        
        newItemText = ""
    }
    
    private func deleteItem(at offsets: IndexSet) {
        note.checklist.remove(atOffsets: offsets)
        updateNote()
    }
    
    private func updateNote() {
        if let index = viewModel.notes.firstIndex(where: { $0.id == note.id }) {
                viewModel.notes[index] = note
                print("Обновляем заметку \(note.title), теперь в ней \(note.checklist.count) элементов")
                
                for item in note.checklist {
                    print("Элемент: \(item.text), ID: \(item.id)")
                }
            }
    }
    
    private func deleteNote() {
            if let index = viewModel.notes.firstIndex(where: { $0.id == note.id }) {
                viewModel.notes.remove(at: index)
                dismiss()
            }
        }
}




// The screen of the list of notes(checklists)
struct NotesView: View {
    @StateObject private var viewModel = NoteViewModel()
    @State private var isNavigating = false
    @State private var newNote: Note?

    var body: some View {
        NavigationView {
            VStack {

                List {
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
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("My checklists")
                        .font(.system(size: 35, weight: .bold))
                        .padding(.top, -20)
                        .padding(.bottom, -120)
                }

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
    }

    private func binding(for note: Note) -> Binding<Note> {
        guard let index = viewModel.notes.firstIndex(where: { $0.id == note.id }) else {
            fatalError("Note not found")
        }
        return $viewModel.notes[index]
    }
}
