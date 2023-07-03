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
        NavigationView {
            VStack {
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
                        Task {
                            await vm.getGameList(genres: 34)
                        }
                    } label: {
                        Text("Load more")
                    }

                }
            }
            .task {
                await vm.getGameList(genres: 34)
            }
            .alert("Error", isPresented: $vm.isAlert) {
                Button("Cancel", role: .cancel) { }
            } message: {
                Text(vm.errorText)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
