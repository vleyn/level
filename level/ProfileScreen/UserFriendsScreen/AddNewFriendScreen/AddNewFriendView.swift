//
//  AddNewFriendView.swift
//  level
//
//  Created by Владислав Мазуров on 15.07.23.
//

import SwiftUI
import Kingfisher

struct AddNewFriendView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm = AddNewFriendViewModel()
    
    var body: some View {
        NavigationView {
            usersList
                .navigationTitle("Add new friend now")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
        }
        .task {
            await vm.getAllUsers()
        }
        .alert("Error", isPresented: $vm.isAlert) {
            Button("Cancel", role: .cancel) { }
        } message: {
            Text(vm.errorText)
        }
    }
    
    private var usersList: some View {
        ScrollView {
            ForEach(vm.users) { user in
                HStack(spacing: 16) {
                    KFImage(URL(string: user.avatar))
                        .placeholder({
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.black)
                        })
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipped()
                        .cornerRadius(50)
                        .overlay(RoundedRectangle(cornerRadius: 50)
                            .stroke(.black, lineWidth: 2)
                        )
                    
                    Text(user.nickname)
                        .foregroundColor(.black)
                    Spacer()
                    Button {
                        vm.sendRequestToUser(targetUser: user)
                    } label: {
                        Image(systemName: vm.isSendRequest ? "clock" : "person.badge.plus")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    .padding(.horizontal)

                }
                .padding(.horizontal)
            }
        }
    }
}

struct AddNewFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewFriendView()
    }
}
