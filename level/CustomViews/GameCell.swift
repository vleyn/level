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
        
        VStack(spacing: 0) {
            KFImage(URL(string: results?.backgroundImage ?? ""))
                .resizable()
                .frame(height:  220)
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 90)
                    .foregroundColor(.indigo)
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(results?.name ?? "Undefined game")
                            .foregroundColor(.white)
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                        HStack {
                            Text("+ \(results?.added ?? 0)")
                                .fontWeight(.heavy)
                                .padding(5)
                                .background(.gray)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                            Spacer()
                        }
                    }
                    Spacer()
                    
                    Text("\(results?.metacritic ?? 0)")
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .overlay(RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.green), lineWidth: 2))
                        .foregroundColor(.green)
                        .bold()
                }
                .padding(.horizontal)
            }
        }
        .cornerRadius(25)
        .overlay(RoundedRectangle(cornerRadius: 25)
            .stroke(Color(.systemIndigo), lineWidth: 2))
        .padding(.horizontal)
    }
}

struct GameCell_Previews: PreviewProvider {
    static var previews: some View {
        GameCell()
    }
}
