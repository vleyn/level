//
//  NewsCell.swift
//  level
//
//  Created by Владислав Мазуров on 18.07.23.
//

import SwiftUI
import Kingfisher

struct NewsCell: View {
    
    var news: GameNews?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            KFImage(URL(string: news?.image ?? ""))
                .resizable()
                .frame(height: 250)
                .cornerRadius(25)
                .mask(LinearGradient(gradient: Gradient(colors: [.clear, .black, .black]), startPoint: .bottom, endPoint: .top))
            Text(news?.header ?? "")
                .foregroundColor(.white)
                .padding()
                .bold()
        }
        .overlay(RoundedRectangle(cornerRadius: 25)
            .stroke(Color(.label), lineWidth: 1))
        .padding(.vertical, 8)
    }
}


struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsCell()
    }
}
