//
//  GameCell.swift
//  level
//
//  Created by Владислав Мазуров on 17.06.23.
//

import SwiftUI

struct GameCell: View {
    
    var image: String = ""
    var gameName: String = ""
    var gameTags: String = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 150)
                .cornerRadius(30)
                .foregroundColor(.gray)
            HStack {
                Image("ImagePlaceHolder")
                    .resizable()
                    .frame(width: 100, height:  130)
                    .cornerRadius(25)
                VStack {
                    Text(gameName)
                        .foregroundColor(.white)
                        .padding()
                    Text(gameTags)
                        .foregroundColor(.white)
                        .padding()
                    
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
