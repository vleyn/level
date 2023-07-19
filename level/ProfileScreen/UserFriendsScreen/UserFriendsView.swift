//
//  UserFriendsView.swift
//  level
//
//  Created by Владислав Мазуров on 7.07.23.
//

import SwiftUI
import Kingfisher

struct UserFriendsView: View {
    
    @StateObject var vm = UserFriendsViewModel()
    
    var body: some View {
        VStack {
            if vm.friends.isEmpty { noFriendsView }
            else { haveFriendsView }
        }
        .fullScreenCover(isPresented: $vm.allUsersIsPresented) {
            AddNewFriendView()
        }
        .navigationTitle("Friends")
        .task {
            vm.fetchUserFriends()
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
    private var haveFriendsView: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    addFriendsButton
                    Divider()
                    friendsCountView
                    friendsList
                }
            }
            .searchable(text: $vm.searchFriendText)
        }
    }
    private var addFriendsButton: some View {
        Button {
            vm.allUsersIsPresented.toggle()
        } label: {
            HStack(spacing: 16) {
                Image(systemName: "person.fill.badge.plus")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(10)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(30)
                VStack(alignment: .leading) {
                    Text("Add friends from recommendations")
                    Text("Maybe you know these people")
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
        .padding(.horizontal)
    }
    private var friendsCountView: some View {
        HStack {
            Text("My friends")
                .bold()
            Text("\(vm.friends.count)")
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
    }
    private var friendsList: some View {
        ForEach(vm.searchResults, id: \.id) { friend in
            VStack {
                HStack(spacing: 16) {
                    KFImage(URL(string: friend.avatar))
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
                        .padding(.leading)
                    
                    Text(friend.nickname)
                        .bold()
                    
                    Spacer()
                           
                    NavigationLink {
                        ChatLogView(chatUser: .init(data: [DatabaseConstants.uid : friend.uid,
                                                           DatabaseConstants.nickname: friend.nickname,
                                                           DatabaseConstants.avatar: friend.avatar]))
                    } label: {
                        Image(systemName: "message")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct UserFriendsView_Previews: PreviewProvider {
    static var previews: some View {
        UserFriendsView()
    }
}
