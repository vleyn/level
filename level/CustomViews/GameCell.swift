//
//  GameCell.swift
//  level
//
//  Created by Владислав Мазуров on 17.06.23.
//

import SwiftUI
import Kingfisher

struct GameCell: View {
    
    var results: Results?
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 150)
                .cornerRadius(30)
                .foregroundColor(.gray)
            HStack {
                KFImage(URL(string: results?.backgroundImage ?? ""))
                    .resizable()
                    .frame(width: 180, height:  130)
                    .cornerRadius(25)
                VStack {
                    Text(results?.name ?? "")
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                    
                }
                Spacer()
            }
            .padding(.leading, 10)
        }
        .padding([.leading, .trailing])
    }
}

struct GameCell_Previews: PreviewProvider {
    static var previews: some View {
        GameCell()
    }
}
