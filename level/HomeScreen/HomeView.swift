//
//  HomeView.swift
//  level
//
//  Created by Владислав Мазуров on 17.06.23.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
            VStack {
                HStack {
                    Text("Welcome, \(UserCache.shared.nickname)!")
                        .font(.system(size: 30))
                    Spacer()
                    KFImage(URL(string: UserCache.shared.avatar))
                        .placeholder {
                            Image(systemName: "person.fill")
                        }
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipped()
                        .cornerRadius(50)
                        .overlay(RoundedRectangle(cornerRadius: 50)
                            .stroke(Color(.label), lineWidth: 1))
                }.padding()
                VStack {
                    HStack {
                        Text("Game categories")
                            .bold()
                        Spacer()
                        Button {
                            //
                        } label: {
                            Text("See more")
                        }

                    }
                    
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Button {
                                    Task {
                                    }
                                } label: {
                                    Text("All")
                                        .padding(10)
                                        .foregroundColor(.white)
                                }
                                ForEach(vm.genres.prefix(10), id: \.id) { item in
                                    Button {
                                        Task {
                                            await vm.getGenresGameList(genres: item)
                                        }
                                    } label: {
                                        Text(item.name ?? "")
                                            .padding(10)
                                            .foregroundColor(.white)
                                    }
                                    .background(vm.currentPickedGenre?.id == item.id ? .green : .gray)
                                    .cornerRadius(16)
                                }
                            }
                        }
                    
                }.padding()
                ScrollView {
                    ForEach(vm.results, id: \.id) { item in
                        
                        NavigationLink {
                            GameDetailsView(gameInfo: item)
                        } label: {
                            GameCell(results: item)
                                .padding(5)
                        }
                    }
                    Button {
//                        Task {
//                            await vm.getGameList(genres: 34)
//                        }
                    } label: {
                        Text("Load more")
                    }

                }
            }
            .task {
                if let currentGenre = vm.currentPickedGenre {
                    await vm.getGenresGameList(genres: currentGenre)
                }
                await vm.getGameGenres()
            }
            .alert("Error", isPresented: $vm.isAlert) {
                Button("Cancel", role: .cancel) { }
            } message: {
                Text(vm.errorText)
            }
        
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
