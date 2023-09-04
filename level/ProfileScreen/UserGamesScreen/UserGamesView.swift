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
        VStack {
            if UserCache.shared.purchasedGames.isEmpty {
                VStack(spacing: 30) {
                    Image(systemName: "flag.2.crossed.fill")
                        .resizable()
                        .frame(width: 150, height: 100)
                        .foregroundColor(.invertedBW)
                    Text("You haven't bought any games yet")
                }
            } else {
                userGameList
            }
        }
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
