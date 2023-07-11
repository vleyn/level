//
//  GameWishCell.swift
//  level
//
//  Created by Владислав Мазуров on 11.07.23.
//

import SwiftUI
import Kingfisher

struct GameWishCell: View {
    
    var game: GameDetail?
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 150)
                .cornerRadius(30)
                .foregroundColor(.gray)
            HStack {
                KFImage(URL(string: game?.backgroundImage ?? ""))
                    .resizable()
                    .frame(width: 180, height:  130)
                    .cornerRadius(25)
                VStack {
                    Text(game?.name ?? "")
                    Button {
                        //
                    } label: {
                        Text("Buy")
                    }
                }
                Spacer()
            }
            .padding(.leading, 10)
        }
        .padding(.horizontal)
    }
}

struct GameWishCell_Previews: PreviewProvider {
    static var previews: some View {
        GameWishCell()
    }
}
