//
//  ChatLogView.swift
//  level
//
//  Created by Vlad on 23.06.23.
//

import SwiftUI

struct ChatLogView: View {
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        self.vm = .init(chatUser: chatUser)
    }
    
    @ObservedObject var vm: ChatLogViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            messagesView
        }
        .navigationTitle(vm.chatUser?.nickname ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Error", isPresented: $vm.isAlert) {
            Button("Cancel", role: .cancel) { }
        } message: {
            Text(vm.errorText)
        }
    }
    
    private var messagesView: some View {
        VStack {
            ScrollView {
                ScrollViewReader { scrollViewProxy in
                    VStack {
                        ForEach(vm.chatMessages) { message in
                            VStack {
                                if message.fromId == vm.firebaseManager.auth.currentUser?.uid {
                                    HStack {
                                        Spacer()
                                        HStack {
                                            Text(message.text)
                                                .foregroundColor(.white)
                                        }
                                        .padding()
                                        .background(.indigo)
                                        .cornerRadius(20)
                                    }
                                } else {
                                    HStack {
                                        HStack {
                                            Text(message.text)
                                                .foregroundColor(.white)
                                        }
                                        .padding()
                                        .background(.gray)
                                        .cornerRadius(20)
                                        Spacer()
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 8)
                        }
                    }
                    HStack { Spacer() }
                        .id(vm.emptyScrollToString)
                        .onReceive(vm.$newMessageCount) { _ in
                            withAnimation(.easeOut(duration: 0.5)) {
                                scrollViewProxy.scrollTo(vm.emptyScrollToString, anchor: .bottom)
                            }
                        }
                }
            }
            .background(Color(.init(.normalBW)))
            .safeAreaInset(edge: .bottom) {
                chatBottomBar
                    .background(Color(.systemBackground).ignoresSafeArea())
            }
        }
    }
    private var chatBottomBar: some View {
        HStack(spacing: 16) {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
                .foregroundColor(Color(.darkGray))
            ZStack {
                DescriptionPlaceholder()
                TextEditor(text: $vm.chatText)
                    .opacity(vm.chatText.isEmpty ? 0.5 : 1)
            }
            .frame(height: 40)
            
            Button {
                vm.handleSend()
            } label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(.indigo)
            .cornerRadius(16)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

private struct DescriptionPlaceholder: View {
    var body: some View {
        HStack {
            Text("Description")
                .foregroundColor(Color(.gray))
                .font(.system(size: 17))
                .padding(.leading, 5)
                .padding(.top, -4)
            Spacer()
        }
    }
}
