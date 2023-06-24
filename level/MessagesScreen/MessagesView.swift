//
//  MessagesView.swift
//  level
//
//  Created by Владислав Мазуров on 18.06.23.
//

import SwiftUI
import Kingfisher

struct MessagesView: View {
    
    @StateObject var vm = MessagesViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack {
                customNavBar
                messagesView
            }
            .overlay(newMessageButton, alignment: .bottom)
            .navigationBarHidden(true)
            .task {
                vm.getChatUser()
                vm.getRecentMessages()
            }
        }
    }
    
    private var customNavBar: some View {
        HStack(spacing: 16) {
            
            KFImage(URL(string: vm.chatUser?.avatar ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipped()
                .cornerRadius(50)
                .overlay(RoundedRectangle(cornerRadius: 44)
                            .stroke(Color(.label), lineWidth: 1)
                )
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(vm.chatUser?.nickname ?? "")
                    .font(.system(size: 24, weight: .bold))
                
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }
            }
            Spacer()
        }
        .padding()
    }
    
    private var messagesView: some View {
        ScrollView {
            ForEach(vm.recentMessages) { message in
                VStack {
                    NavigationLink {
                        Text("Destination")
                    } label: {
                        HStack(spacing: 16) {
                            KFImage(URL(string: message.avatar))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                                .clipped()
                                .cornerRadius(64)
                                .overlay(RoundedRectangle(cornerRadius: 64)
                                        .stroke(Color.black, lineWidth: 2))
                        
                            VStack(alignment: .leading, spacing: 7) {
                                Text(message.nickname)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(.label))
                                Text(message.text)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(.lightGray))
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            
                            Text("1d")
                                .font(.system(size: 14, weight: .semibold))
                        }
                    }

                    Divider()
                        .padding(.vertical, 8)
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 50)
        }
        .padding(.bottom, 70)
    }
        
    private var newMessageButton: some View {
        Button {
            vm.showNewMessageScreen.toggle()
        } label: {
            HStack {
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical)
            .background(Color.gray)
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 15)
        }
        .padding(.bottom, 90)
        .fullScreenCover(isPresented: $vm.showNewMessageScreen) {
            WriteNewMessageView()
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
