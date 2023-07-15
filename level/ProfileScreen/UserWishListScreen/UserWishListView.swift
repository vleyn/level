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
        userWishList
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
