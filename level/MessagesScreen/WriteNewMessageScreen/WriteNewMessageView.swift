//
//  WriteNewMessageView.swift
//  level
//
//  Created by Vlad on 23.06.23.
//

import SwiftUI
import Kingfisher

struct WriteNewMessageView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm = WriteNewMessageViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if vm.friends.isEmpty { noFriendsView }
                else { usersList }
            }
            .navigationTitle("New message")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            .fullScreenCover(isPresented: $vm.allUsersIsPresented) {
                AddNewFriendView()
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
            ForEach(vm.friends) { user in
                Button {
                } label: {
                    NavigationLink {
                        ChatLogView(chatUser: user)
                    } label: {
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
                                .foregroundColor(.invertedBW)
                            Spacer()
                        }
                        .padding(.horizontal)
                        Divider()
                            .padding(.vertical, 8)
                    }
                    
                }
            }
        }
    }
    
    private var noFriendsView: some View {
        VStack {
            VStack(spacing: 30) {
                Image(systemName: "person.2.slash.fill")
                    .resizable()
                    .frame(width: 150, height: 120)
                    .foregroundColor(.invertedBW)
                Text("You dont have any friends :(")
            }
            
            Button {
                vm.allUsersIsPresented.toggle()
            } label: {
                Text("Add now +")
                    .padding()
                    .background(.indigo)
                    .foregroundColor(.normalBW)
                    .cornerRadius(16)
            }

        }
    }

}

struct WriteNewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        WriteNewMessageView()
    }
}
