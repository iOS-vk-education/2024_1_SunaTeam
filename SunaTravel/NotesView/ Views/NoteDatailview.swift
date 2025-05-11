//
//  NoteDatailview.swift
//  SunaTravel
//
//  Created by Lilia Chechina on 03.05.2025.
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
                    .cornerRadius(8)
                    .background(Color(.systemBackground))
                    .onChange(of: note.title) { _ in
                                            updateNote()
                                        }
                
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
                .onAppear {
                    isTitleFocused = true
                }
                .padding()
                .background(Color(.systemBackground))
                .edgesIgnoringSafeArea(.all)
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
                .padding(.horizontal)
                .padding(.top, 0.17)
            }
        }

    private func toggleItem(_ item: ChecklistItem) {
           if let index = note.checklist.firstIndex(where: { $0.id == item.id }) {
               note.checklist[index].isChecked.toggle()
               updateNote()
           }
       }

       private func addItem() {
           guard !newItemText.isEmpty else { return }
           if !note.checklist.contains(where: { $0.text == newItemText }) {
               let newItem = ChecklistItem(text: newItemText)
               note.checklist.append(newItem)
               updateNote()
           }
           newItemText = ""
       }

       private func deleteItem(at offsets: IndexSet) {
           note.checklist.remove(atOffsets: offsets)
           updateNote()
       }

       private func updateNote() {
           viewModel.updateNote(note)
       }

       private func deleteNote() {
               if let selectedNote = viewModel.selectedNote, selectedNote.id == note.id {
                   viewModel.selectedNote = nil
               }
           viewModel.deleteNote(note: note)
           dismiss()
       }
}
