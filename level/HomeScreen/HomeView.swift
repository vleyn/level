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
//            ForEach($vm.results, id: \.id) { game in
//                GameCell(gameName: "game.name!", gameTags: "game.tags?.first")
//            }
            ScrollView {
                ForEach(vm.results, id: \.id) { item in
                    GameCell(gameName: item.name!)
                }
            }
        }
        .task {
            await vm.getGameList(page: 1, genres: 34)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
