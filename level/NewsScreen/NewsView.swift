//
//  NewsView.swift
//  level
//
//  Created by Владислав Мазуров on 18.06.23.
//

import SwiftUI
import AVKit

struct NewsView: View {
    var body: some View {
        VideoPlayer(player: AVPlayer(url:  URL(string: "https://media.rawg.io/media/stories/8a1/8a17d3fc984d01379a83338b2d753c37.mp4")!))
            .frame(height: 400)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
