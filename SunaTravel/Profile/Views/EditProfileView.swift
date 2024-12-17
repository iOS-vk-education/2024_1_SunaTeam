//
//  EditProfileView.swift
//  Suna Travel
//
//  Created by salfetka on 20.11.2024.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    @State private var tempName: String
    @State private var tempEmail: String
    @State private var tempLocation: String
    @State private var tempPhoneNumber: String
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        _tempName = State(initialValue: viewModel.profile.name)
        _tempEmail = State(initialValue: viewModel.profile.email)
        _tempLocation = State(initialValue: viewModel.profile.location)
        _tempPhoneNumber = State(initialValue: viewModel.profile.phoneNumber)
    }

    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.top)
                
                Button(action: {}) {
                    Text("Change Profile Picture")
                        .foregroundColor(.orange)
                }

                VStack(alignment: .leading, spacing: 15) {
                    ProfileInputField(title: "Name", text: $tempName)
                    ProfileInputField(title: "Email", text: $tempEmail)
                    ProfileInputField(title: "Location", text: $tempLocation)
                    ProfileInputField(title: "Mobile Number", text: $tempPhoneNumber)
                }
                .padding()

                Spacer()
            }
        }
        .navigationBarTitle("Edit Profile", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: saveChanges) {
                    Text("Save").foregroundColor(.orange).fontWeight(.bold)
                }
            }
        }
        .alert(isPresented: $viewModel.isShowedSuccessMessage) {
            Alert(
                title: Text("Success"),
                message: Text("Changes have been saved successfully.")
            )
        }
    }
    
    private func saveChanges() {
        viewModel.saveChanges(
            name: tempName,
            email: tempEmail,
            location: tempLocation,
            phoneNumber: tempPhoneNumber
        )
    }
}
