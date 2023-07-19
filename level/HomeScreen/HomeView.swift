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
            pickGenreSection
            gameList
        }
        .task {
            await vm.getGameGenres()
        }
        .alert("Error", isPresented: $vm.isAlert) {
            Button("Cancel", role: .cancel) { }
        } message: {
            Text(vm.errorText)
        }
        .navigationTitle("Welcome, \(UserCache.shared.nickname)!")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var pickGenreSection: some View {
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
                            vm.tapToGenresButtonCount += 1
                            await vm.getFullGameList()
                        }
                    } label: {
                        Text("All")
                            .padding(10)
                            .foregroundColor(.invertedBW)
                    }
                    .background(vm.allGenresPicked ? .indigo : .clear)
                    .overlay(RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(.label), lineWidth: 1))
                    .cornerRadius(16)
                    ForEach(vm.genres.prefix(10), id: \.id) { item in
                        Button {
                            Task {
                                vm.tapToGenresButtonCount += 1
                                await vm.getGameListByGenre(genres: item)
                            }
                        } label: {
                            Text(item.name ?? "")
                                .padding(10)
                                .foregroundColor(.invertedBW)
                        }
                        .background(vm.currentPickedGenre?.id == item.id ? .indigo : .clear)
                        .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(.label), lineWidth: 1))
                        .cornerRadius(16)
                    }
                }
            }
        }
        .padding()
    }
    
    private var gameList: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                HStack { Spacer() }
                    .id(vm.emptyScrollToString)
                    .onReceive(vm.$tapToGenresButtonCount) { _ in
                        withAnimation(.easeOut(duration: 0.5)) {
                            scrollViewProxy.scrollTo(vm.emptyScrollToString, anchor: .bottom)
                        }
                    }
                    if let currentGenre = vm.currentPickedGenre {
                        
                        LazyVStack {
                            ForEach(vm.genreResults, id: \.id) { item in
                                NavigationLink {
                                    GameDetailsView(gameInfo: item)
                                } label: {
                                    GameCell(results: item)
                                        .padding(5)
                                }
                            }
                            if vm.showSpinner {
                                ProgressView()
                                    .onAppear(){
                                        Task {
                                            await vm.getGameListByGenre(genres: currentGenre)
                                        }
                                    }
                            }
                            
                        }
                    } else {
                        LazyVStack {
                            ForEach(vm.fullGameListResults, id: \.id) { item in
                                NavigationLink {
                                    GameDetailsView(gameInfo: item)
                                } label: {
                                    GameCell(results: item)
                                        .padding(5)
                                }
                            }
                            if vm.showSpinner {
                                ProgressView()
                                    .onAppear(){
                                        Task {
                                            await vm.getFullGameList()
                                        }
                                    }
                            }
                        }
                    }
                
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
