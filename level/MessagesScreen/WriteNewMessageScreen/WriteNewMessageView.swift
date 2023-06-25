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
            ScrollView {
                ForEach(vm.users) { user in
                    Button {
                    } label: {
                        NavigationLink {
                            ChatLogView(chatUser: user)
                        } label: {
                            HStack(spacing: 16) {
                                if user.avatar.isEmpty {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.black)
                                }
                                else {
                                    KFImage(URL(string: user.avatar))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipped()
                                        .cornerRadius(50)
                                        .overlay(RoundedRectangle(cornerRadius: 50)
                                            .stroke(.black, lineWidth: 2)
                                        )
                                }
                                
                                Text(user.nickname)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            .padding(.horizontal)
                            Divider()
                                .padding(.vertical, 8)
                        }

                    }

                }
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
}

struct WriteNewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        WriteNewMessageView()
    }
}
