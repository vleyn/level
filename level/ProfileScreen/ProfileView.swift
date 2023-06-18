//
//  ProfileVIew.swift
//  level
//
//  Created by Владислав Мазуров on 16.06.23.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var vm = ProfileViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    Image("ImagePlaceHolder")
                        .resizable()
                        .ignoresSafeArea()
                        .frame(height: 170)
                    ZStack {
                        Button {
                            print("editProfile")
                        } label: {
                        Image(systemName: "pencil")
                                .foregroundColor(.black)
                                .padding(14)
                                .background(.white)
                                .clipShape(Circle())
                                
                        }
                        .padding()
                    }
                }
                ZStack {
                    Rectangle()
                        .foregroundColor(.gray)
                        .ignoresSafeArea()
                    VStack {
                        Text(vm.nickName)
                            .bold()
                            .font(.system(size: 28))
                            .padding(.top, 70)
                        HStack {
                            Button {
                                print("friends")
                            } label: {
                                VStack {
                                    Text("24")
                                        .bold()
                                    Text("Friends")
                                }
                                .foregroundColor(.black)
                            }
                            .frame(width: 130, height: 70)
                            .background(.blue)
                            .cornerRadius(25)
                            Button {
                                print("friends")
                            } label: {
                                VStack {
                                    Text("12")
                                        .bold()
                                    Text("Games")
                                }
                                .foregroundColor(.black)
                            }
                            .frame(width: 130, height: 70)
                            .background(.blue)
                            .cornerRadius(25)
                        }
                        VStack(alignment: .leading) {
                            Section("Bio") {
                                Text("Some info about user")
                            }
                            Section("Links") {
                                Text("User links")
                            }
                        }
                        .padding(.trailing, 100)
                        .padding(.top, 30)
                        Spacer()
                        Button {
                            Task {
                                try await vm.logOut()
                            }
                        } label: {
                            Text("Logout")
                                .fontDesign(.rounded)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding([.top, .bottom], 12)
                                .padding([.leading, .trailing], 76)
                                .background(.blue)
                                .cornerRadius(8)
                        }
                        .padding(.bottom, 90)
                    }
                }
            }
            Image("avatar")
                .padding(.top, 100)
        }
        .task {
            await vm.databaseRead()
        }
        .fullScreenCover(isPresented: $vm.isLogout) {
            LoginView()
        }
    }
}

struct ProfileVIew_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}