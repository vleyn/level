//
//  UserGamesView.swift
//  level
//
//  Created by Владислав Мазуров on 7.07.23.
//

import SwiftUI

struct UserGamesView: View {
    
    @StateObject var vm = UserGamesViewModel()
    
    var body: some View {
        userGameList
            .task {
                await vm.fetchGameList()
            }
            .navigationTitle("Game List")
    }

    private var userGameList: some View {
        ScrollView {
            ForEach(vm.purchasedGames, id: \.id) { game in
                GameWishCell(game: game)
            }
        }
    }
}

struct UserGamesView_Previews: PreviewProvider {
    static var previews: some View {
        UserGamesView()
    }
}
