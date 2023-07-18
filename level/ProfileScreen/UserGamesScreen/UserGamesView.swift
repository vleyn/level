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
            .navigationTitle("Game List")
    }

    private var userGameList: some View {
        ScrollView {
            ForEach(UserCache.shared.purchasedGames.reversed(), id: \.id) { game in
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
