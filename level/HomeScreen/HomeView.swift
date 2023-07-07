//
//  HomeView.swift
//  level
//
//  Created by Владислав Мазуров on 17.06.23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
            VStack {
                HStack {
                    Text("Welcome, \(UserCache.shared.nickname)!")
                        .font(.system(size: 30))
                    Spacer()
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
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
                                ForEach(vm.genres.prefix(10), id: \.id) { item in
                                    Button {
                                        Task {
                                            await vm.getGameList(genres: item)
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
                            GameDetailsView(gameId: item.id)
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
                    await vm.getGameList(genres: currentGenre)
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
