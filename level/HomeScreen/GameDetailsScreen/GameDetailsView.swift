//
//  GameDetailsView.swift
//  level
//
//  Created by Владислав Мазуров on 28.06.23.
//

import SwiftUI
import Kingfisher
import AVKit

struct GameDetailsView: View {
        
    var gameInfo: Results?
    @StateObject var vm = GameDetailsViewModel()
    
    var body: some View {
        ScrollView {
            ScrollView(.horizontal, showsIndicators: false) {
                if let screenshots = gameInfo?.shortScreenshots {
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack {
                            ForEach(screenshots, id: \.id) { screenShot in
                                KFImage(URL(string: screenShot.image ?? ""))
                                    .placeholder({
                                        Image(systemName: "folder")
                                    })
                                    .resizable()
                                    .frame(width: 400, height: 250)
                                    .ignoresSafeArea()
                                    .cornerRadius(20)
                                    .padding()
                            }
                        }
                    }
                }
            }
            
            Text(gameInfo?.name ?? "")
                .bold()
                .padding()
            VStack(alignment: .leading, spacing: 16) {
                if let genres = gameInfo?.genres {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(genres, id: \.id) { genre in
                                Text(genre.name ?? "")
                                    .padding(8)
                                    .background(.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                            }
                        }
                    }
                    
                }
                Divider()
                
                Text("About")
                    .bold()
                Button {
                    vm.isViewed.toggle()
                } label: {
                    Text(vm.additionalInfo?.descriptionRaw ?? "")
                        .multilineTextAlignment(.leading)
                        .lineLimit(vm.isViewed ? 100 : 7)
                        .foregroundColor(.black)
                }
                Divider()
                
                Text("Rating")
                    .bold()
                let rating = "\(gameInfo?.rating ?? 0) / \(gameInfo?.ratingTop ?? 0) ★"
                Text(rating)
                    .bold()
                    .padding(8)
                    .background(.green)
                    .foregroundColor(.yellow)
                    .cornerRadius(16)
                
                Divider()
                
                Text("Released at")
                    .bold()
                Text(gameInfo?.released ?? "")
            }
            .padding()
        }
        .task {
            await vm.getAdditionalInfo(id: gameInfo?.id ?? 0)
            await vm.getGameTrailer(id: gameInfo?.id ?? 0)
        }
        .alert("Error", isPresented: $vm.isAlert) {
            Button("Cancel", role: .cancel) { }
        } message: {
            Text(vm.errorText)
        }
        .navigationTitle(gameInfo?.name ?? "")
    }
    
    struct GameDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            GameDetailsView()
        }
    }
}
