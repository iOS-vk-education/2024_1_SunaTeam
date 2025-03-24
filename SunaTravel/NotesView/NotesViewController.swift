//
//  NotesViewController.swift
//  SunaTravel
//
//  Created by Lilia Chechina on 12.03.2025.
//
import SwiftUI

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
                    .padding(.leading, -2)
                    .padding(8)
                    .cornerRadius(8)
                
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
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)) // Убираем отступы между строками
                    }
                    .onDelete(perform: deleteItem)
                    HStack {
                        Image(systemName: "circle") // Пустой чекбокс для нового элемента
                        TextField("New item", text: $newItemText, onCommit: addItem) // Обработчик для добавления нового элемента
                                .padding(8)
                                .background(Color(UIColor.secondarySystemBackground)) // Чтобы поле было видно
                                .cornerRadius(8)
                                .onSubmit { // Используем onSubmit для явной обработки события
                                    addItem()
                                    newItemText = "" // Сбрасываем текст после добавления
                                }
//                        TextField("New item", text: $newItemText, onCommit: addItem) // Обработчик для добавления нового элемента
//                            .padding(8)
//                        /*    .background(Color(UIColor.secondarySystemBackground)) */ // Maybe make white
//                            .cornerRadius(8)
                    }
                }
                    // Ряд для ввода нового элемента с чекбоксом
//                    HStack {
//                        Image(systemName: "circle") // Пустой чекбокс для нового элемента
//                        TextField("New item", text: $newItemText, onCommit: addItem) // Обработчик для добавления нового элемента
//                            .padding(8)
//                        /*    .background(Color(UIColor.secondarySystemBackground)) */ // Maybe make white
//                            .cornerRadius(8)
//                    }
                }
                
                //            VStack(alignment: .leading) {
                //                TextEditor(text: $newItemText)
                //                    .padding(8)
                //                    .background(Color(UIColor.secondarySystemBackground))
                //                    .cornerRadius(8)
                //                    .frame(height: 200)
                //                    .overlay(
                //                        HStack {
                //                            Button(action: addItem) {
                //                                Image(systemName: "plus.circle.fill")
                //                                    .foregroundColor(.blue)
                //                                    .font(.system(size: 24))
                //                            }
                //                            .padding(.leading, 8) // Speaking to the left
                //                            .disabled(newItemText.isEmpty)
                //
                //                            Spacer() // to keep the button on the left
                //                        }
                //                    )
                //                // Return key processor
                //                    .onSubmit {
                //                        addItem() // adding a new element by pressing "Return"
                //                }
                //            }
                //            .padding(.horizontal)
                //        .padding()
                .listStyle(PlainListStyle())
//                .frame(height: geometry.size.height - 150)
//                .frame(maxHeight: .infinity)  // so that less space on the screen occupies, but isn't working
                .onAppear {
                    isTitleFocused = true
                }
                .padding()
                .background(Color.white)
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
//        guard !newItemText.isEmpty else { return }
//        let newItem = ChecklistItem(text: newItemText)
//        print("Добавляем: \(newItem.text), ID: \(newItem.id)")
//        note.checklist.append(newItem)
//        newItemText = ""
//        updateNote()
//        guard !newItemText.isEmpty else { return }
//        let newItem = ChecklistItem(text: newItemText)
//        print("Добавляем: \(newItem.text), ID: \(newItem.id)")
//
//        note.checklist.append(newItem)
//        newItemText = ""  // Убеждаемся, что поле очищается
//
//        updateNote()  // Обновляем заметку после добавления нового элемента
//        newItemText = ""  // Убеждаемся, что поле очищается
        // MARK: Костыль
        guard !newItemText.isEmpty else { return }
        
        // Проверяем, существует ли уже элемент с таким же текстом
        if !note.checklist.contains(where: { $0.text == newItemText }) {
            let newItem = ChecklistItem(text: newItemText)
            print("Добавляем: \(newItem.text), ID: \(newItem.id)")
            
            note.checklist.append(newItem)
        } else {
            print("Элемент уже существует: \(newItemText)")
        }
        
        newItemText = "" // Сбрасываем текстовое поле
    }
    
    private func deleteItem(at offsets: IndexSet) {
        note.checklist.remove(atOffsets: offsets)
        updateNote()
    }
    
    private func updateNote() {
//        if let index = viewModel.notes.firstIndex(where: { $0.id == note.id }) {
//            viewModel.notes[index] = note
//        }
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

struct NotesView: View {
    @StateObject private var viewModel = NoteViewModel()
    @State private var isNavigating = false // Управление навигацией к новой заметке
    @State private var newNote: Note? // Переменная для новой заметки
    
    @State private var newTitle: String = ""
    @State private var newText: String = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach($viewModel.notes) { $note in
                    NavigationLink(destination: NoteDetailView(viewModel: viewModel, note: $note)) {
                        Text(note.title)
                            .font(.headline)
                    }
                }
                .onDelete(perform: viewModel.deleteNote)
            }
            .navigationTitle("My checklists")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                let note = Note(title: "", text: "")
                viewModel.notes.append(note)
                newNote = note
                isNavigating = true
                }) {
                    Image(systemName: "plus.circle.fill")
                .font(.system(size: 30))
                }
                }
            }
        }
    }
}



// Implementation with a git
//import SwiftUI
//
//struct NotesView: View {
//    @StateObject private var viewModel = NoteViewModel()
//    
//    // Fields for a new note
//    @State private var newTitle: String = ""
//    @State private var newText: String = ""
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                // List of notes
//                List {
//                    ForEach(viewModel.notes) { note in
//                        // Transition to a detailed screen or just a conclusion(output)
//                        NavigationLink(destination: NoteDetailView(note: note)) {
//                            Text(note.title)
//                                .font(.headline)
//                        }
//                    }
//                    .onDelete(perform: viewModel.deleteNote)
//                }
//                
//                // Section for adding a new note
//                VStack(alignment: .leading, spacing: 8) {
//                    TextField("Tittle", text: $newTitle)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                    TextField("The text of the note", text: $newText)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                    
//                    Button(action: {
//                        guard !newTitle.isEmpty else { return }
//                        // Add a note and clean the fields
//                        viewModel.addNote(title: newTitle, text: newText)
//                        newTitle = ""
//                        newText = ""
//                    }) {
//                        Text("Add")
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(8)
//                    }
//                }
//                .padding()
//            }
//            .navigationTitle("My notes")
//        }
//    }
//}
//
//struct NoteDetailView: View {
//    let note: Note
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 16) {
//            Text(note.title)
//                .font(.title)
//                .bold()
//            
//            Text(note.text)
//                .font(.body)
//        }
//        .padding()
//    }
//}
//
//struct NotesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

//import UIKit
//
//class NotesViewController: UIViewController {
//
//    private var notes: [String] = []
//    private let tableView = UITableView()
//    private let addButton = UIButton(type: .system)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        title = "Notes"
//        setupTableView()
//        setupAddButton()
//        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissSelf))
//    }
//
//    private func setupTableView() {
//        tableView.frame = view.bounds
//        tableView.dataSource = self
//        view.addSubview(tableView)
//    }
//
//    private func setupAddButton() {
//        addButton.setTitle("Add Note", for: .normal)
//        addButton.addTarget(self, action: #selector(addNote), for: .touchUpInside)
//        addButton.frame = CGRect(x: 20, y: view.frame.height - 60, width: view.frame.width - 40, height: 40)
//        view.addSubview(addButton)
//    }
//
//    @objc private func addNote() {
//        let alertController = UIAlertController(title: "New Note", message: nil, preferredStyle: .alert)
//        alertController.addTextField { textField in
//            textField.placeholder = "Note Content"
//        }
//        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
//            if let note = alertController.textFields?.first?.text, !note.isEmpty {
//                self.notes.append(note)
//                self.tableView.reloadData()
//            }
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alertController.addAction(saveAction)
//        alertController.addAction(cancelAction)
//        present(alertController, animated: true, completion: nil)
//    }
//
//    @objc private func dismissSelf() {
//        dismiss(animated: true, completion: nil)
//    }
//}
//
//extension NotesViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return notes.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        cell.textLabel?.text = notes[indexPath.row]
//        return cell
//    }
//}
