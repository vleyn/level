//
//  EditProfileView.swift
//  level
//
//  Created by Владислав Мазуров on 18.06.23.
//

import SwiftUI

struct EditProfileView: View {
    
    @StateObject var vm = EditProfileViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            Button {
                print("edit photo")
            } label: {
                Image("avatar")
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
        .padding([.leading, .trailing])
        .task {
            vm.getUserInfo()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
