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
        .sheet(isPresented: $vm.showBuyMenu) {
            purchaseWindow
                .presentationDetents([.height(400)])
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
                vm.showBuyMenu.toggle()
            } label: {
                HStack {
                    Text("119$")
                        .bold()
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
    private var purchaseWindow: some View {
        VStack {
            HStack {
                Text("Level")
                    .bold()
                Spacer()
                Button {
                    vm.showBuyMenu.toggle()
                } label: {
                    Text("Return")
                        .bold()
                }
            }
            .padding()
            HStack(spacing: 16) {
                KFImage(URL(string: gameInfo?.backgroundImage ?? ""))
                    .placeholder {
                        Image(systemName: "folder")
                    }
                    .resizable()
                    .frame(width: 53, height: 53)
                    .cornerRadius(16)
                VStack(alignment: .leading, spacing: 0) {
                    Text(gameInfo?.name ?? "")
                        .font(.system(size: 15))
                    Text("Level app")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    Text("Buying a game")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.leading, 39)
            Divider()
            HStack {
                VStack {
                    Text("POLICY")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.bottom, 65)
                }
                VStack {
                    Text("Your game will be buying now. You can recieve a refund for the remainder of your bought game. Refund at 7-days in Settings > Apple ID at least one day before each renewal date.")
                        .font(.system(size: 14))
                }
            }
            .padding(.horizontal, 50)
            Divider()
                HStack {
                    Text("ACCOUNT")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    Text(UserCache.shared.email)
                    Spacer()
                }
                .padding(.leading, 30)
            Divider()
                HStack {
                    Text("PRICE")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    Text("USD, \(Int.random(in: 10..<100))")
                    Spacer()
                }
                .padding(.leading, 59)
            Divider()
            
            Button {
                //
            } label: {
                Text("Buy")
                    .padding(.horizontal, 30)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(16)
                    
            }
            .padding(.vertical, 16)
        }
    }

    
    struct GameDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            GameDetailsView()
        }
    }
}
