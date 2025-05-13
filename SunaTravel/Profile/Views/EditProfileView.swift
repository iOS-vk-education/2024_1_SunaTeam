//
//  EditProfileView.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 24.12.2024.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    @State private var tempName: String
    @State private var tempEmail: String
    @State private var tempLocation: String
    @State private var tempPhoneNumber: String
    
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false
    @State var profileImage: UIImage?
    
    @EnvironmentObject var settings: AppSettings
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        _tempName = State(initialValue: viewModel.profile.name)
        _tempEmail = State(initialValue: viewModel.profile.email)
        _tempLocation = State(initialValue: viewModel.profile.location)
        _tempPhoneNumber = State(initialValue: viewModel.profile.phoneNumber)
        if let avatar = viewModel.profile.avatar {
            _selectedImage = State(initialValue: avatar)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.top)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.top)
                }
                
                Button(action: {
                    
                    isImagePickerPresented.toggle()
                }) {
                    Text(EditProfileText.avatar(for: settings.currentLanguage))
                        .foregroundColor(.orange)
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    ProfileInputField(title: EditProfileText.name(for: settings.currentLanguage), text: $tempName)
                    ProfileInputField(title: EditProfileText.email(for: settings.currentLanguage), text: $tempEmail)
                    ProfileInputField(title: EditProfileText.location(for: settings.currentLanguage), text: $tempLocation)
                    ProfileInputField(title: EditProfileText.number(for: settings.currentLanguage), text: $tempPhoneNumber)
                }
                .padding()
                
                Spacer()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: saveChanges) {
                    Text(EditProfileText.save(for: settings.currentLanguage)).foregroundColor(.orange).fontWeight(.bold)
                }
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(isImagePickerPresented: $isImagePickerPresented, selectedImage: $selectedImage)
        }
    }
    
    private func saveChanges() {
        viewModel.saveChanges(
            name: tempName,
            email: tempEmail,
            location: tempLocation,
            phoneNumber: tempPhoneNumber,
            avatar: selectedImage
        )
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isImagePickerPresented: Bool
    @Binding var selectedImage: UIImage?
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var isImagePickerPresented: Bool
        @Binding var selectedImage: UIImage?
        
        init(isImagePickerPresented: Binding<Bool>, selectedImage: Binding<UIImage?>) {
            _isImagePickerPresented = isImagePickerPresented
            _selectedImage = selectedImage
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isImagePickerPresented = false
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                selectedImage = image
            }
            isImagePickerPresented = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isImagePickerPresented: $isImagePickerPresented, selectedImage: $selectedImage)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
