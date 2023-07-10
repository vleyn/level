//
//  EditProfileView.swift
//  level
//
//  Created by Владислав Мазуров on 18.06.23.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    
    @StateObject var vm = EditProfileViewModel()
    
    var body: some View {
        editProfileForm
            .padding(.horizontal)
        .task {
            vm.getUserInfo()
        }
        .fullScreenCover(isPresented: $vm.showImagePicker, onDismiss: nil) {
            ImagePicker(image: $vm.image)
                .ignoresSafeArea()
        }
        .alert("Error", isPresented: $vm.isAlert) {
            Button("Cancel", role: .cancel) { }
        } message: {
            Text(vm.errorText)
        }
    }
    
    private var editProfileForm: some View {
        VStack(spacing: 16) {
            Button {
                vm.showImagePicker.toggle()
            } label: {
                VStack {
                    if let image = vm.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 128, height: 128)
                            .cornerRadius(64)
                            .overlay(RoundedRectangle(cornerRadius: 64)
                                .stroke(Color.black, lineWidth: 3)
                            )
                    } else {
                        KFImage(URL(string: vm.avatar))
                            .placeholder({
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 128, height: 128)
                                    .foregroundColor(.black)
                            })
                            .resizable()
                            .scaledToFill()
                            .frame(width: 128, height: 128)
                            .clipped()
                            .cornerRadius(64)
                            .overlay(RoundedRectangle(cornerRadius: 64)
                                .stroke(Color(.label), lineWidth: 1))
                            .shadow(radius: 5)
                        
                    }
                }
            }
            CustomTextField(bindingValue: $vm.nickname, image: "person.fill", placeHolder: "Nickname")
            CustomTextField(bindingValue: $vm.email, image: "envelope", placeHolder: "Email")
            CustomTextField(bindingValue: $vm.bio, image: "folder", placeHolder: "Bio")
            
            Button {
                vm.saveChanges()
            } label: {
                Text("Save changes")
            }
            
            
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
