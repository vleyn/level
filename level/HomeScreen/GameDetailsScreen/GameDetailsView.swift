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
            screenShotsView
            descriptionView
        }
        .overlay(buyGameButton, alignment: .bottom)
        .task {
            await vm.getAdditionalInfo(id: gameInfo?.id ?? 0)
        }
        .alert("Error", isPresented: $vm.isAlert) {
            Button("Cancel", role: .cancel) { }
        } message: {
            Text(vm.errorText)
        }
        .navigationTitle(gameInfo?.name ?? "")
    }
    
    private var screenShotsView: some View {
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
    }
    private var descriptionView: some View {
        VStack {
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
                
                Text(vm.fullRating ?? "")
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
    }
    private var buyGameButton: some View {
        HStack {
            Button {
                //
            } label: {
                HStack {
                    Text("119$")
                    Text("Buy now")
                }
                .foregroundColor(.white)
                .padding(.vertical)
                .padding(.horizontal)
                .background(Color.gray)
                .cornerRadius(32)
                .shadow(radius: 15)
            }
            Button {
                vm.addToWishList()
            } label: {
                Image(systemName: vm.isWhishList ? "heart.fill" : "heart")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal)
                    .background(Color.gray)
                    .cornerRadius(32)
                    .shadow(radius: 15)
            }

        }
        .padding(.bottom, 40)
    }
    
    struct GameDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            GameDetailsView()
        }
    }
}
