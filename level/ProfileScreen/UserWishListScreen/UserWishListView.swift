//
//  UserWishListView.swift
//  level
//
//  Created by Владислав Мазуров on 7.07.23.
//

import SwiftUI

struct UserWishListView: View {
    
    @StateObject var vm = UserWishListViewModel()
    
    var body: some View {
        VStack {
            if UserCache.shared.wishListGames.isEmpty {
                VStack(spacing: 30) {
                    Image(systemName: "star.slash")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.invertedBW)
                    Text("You have not added any games to your wishlist yet")
                }
            } else {
                userWishList
            }
        }
        .navigationTitle("Wishlist")
    }
    
    
    private var userWishList: some View {
        ScrollView {
            ForEach(UserCache.shared.wishListGames.reversed(), id: \.id) { game in
                GameWishCell(game: game)
            }
        }
    }
}

struct UserWishListView_Previews: PreviewProvider {
    static var previews: some View {
        UserWishListView()
    }
}
