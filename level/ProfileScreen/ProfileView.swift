//
//  ProfileVIew.swift
//  level
//
//  Created by Владислав Мазуров on 16.06.23.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @StateObject var vm = ProfileViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                Image("ImagePlaceHolder")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(height: 170)
                
                List {
                    HStack {
                        Spacer()
                        Text(vm.nickName)
                            .bold()
                            .font(.system(size: 28))
                            .padding(.top)
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                    
                    NavigationLink {
                        EditProfileView()
                    } label: {
                        
                        HStack {
                            Image(systemName: "person.fill")
                            Text("Account")
                        }
                        
                    }
                    .padding()
                    
                    
                    Section {
                        NavigationLink {
                            UserGamesView()
                        } label: {
                            
                            HStack {
                                Image(systemName: "gamecontroller.fill")
                                Text("Games")
                            }
                            
                        }
                        .padding()
                        
                        
                        NavigationLink {
                            UserFriendsView()
                        } label: {
                            
                            HStack {
                                Image(systemName: "person.2.fill")
                                Text("Friends")
                            }
                            
                        }
                        .padding()
                        
                        NavigationLink {
                            UserWishListView()
                        } label: {
                            
                            HStack {
                                Image(systemName: "star.fill")
                                Text("Whishlist")
                            }
                            
                        }
                        .padding()
                        
                        NavigationLink {
                            UserWalletView()
                        } label: {
                            HStack {
                                Image(systemName: "creditcard.fill")
                                Text("Wallet")
                            }
                        }
                        .padding()
                    }
                    
                    
                    Section {
                        Button {
                            vm.showPrivacyPolicy.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "list.clipboard.fill")
                                Text("Privacy policy")
                            }
                            .foregroundColor(.invertedBW)
                        }
                        .padding()
                        
                        Button {
                            vm.logOut()
                        } label: {
                            HStack {
                                Image(systemName: "figure.walk.arrival")
                                Text("Logout")
                            }
                            .foregroundColor(.invertedBW)
                        }
                        .padding()
                    }
                    
                }
            }
            ZStack {
                KFImage(URL(string: vm.avatar))
                    .placeholder({
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 120, height: 120)
                    })
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipped()
                    .cornerRadius(60)
                    .overlay(RoundedRectangle(cornerRadius: 60)
                        .stroke(Color(.label), lineWidth: 1))
                    .shadow(radius: 5)
                    .padding(.top, 100)
            }
        }
        
        .task {
            vm.loadUserInfo()
        }
        .fullScreenCover(isPresented: $vm.isLogout) {
            LoginView()
        }
        .sheet(isPresented: $vm.showPrivacyPolicy, content: {
            PrivacyPolicyView()
        })
        .alert("Error", isPresented: $vm.isAlert) {
            Button("Cancel", role: .cancel) { }
        } message: {
            Text(vm.errorText)
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileVIew_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
