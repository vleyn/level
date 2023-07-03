//
//  GameDetailsView.swift
//  level
//
//  Created by Владислав Мазуров on 28.06.23.
//

import SwiftUI
import Kingfisher

struct GameDetailsView: View {
    
    var gameId: Int?
    
    @StateObject var vm = GameDetailsViewModel()
    
    var body: some View {
        ScrollView {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                        KFImage(URL(string: vm.gameInfo?.backgroundImage ?? ""))
                            .resizable()
                            .frame(width: 400, height: 250)
                            .ignoresSafeArea()
                            .cornerRadius(20)
                            .padding()
                        KFImage(URL(string: vm.gameInfo?.backgroundImageAdditional ?? ""))
                            .resizable()
                            .frame(width: 400, height: 250)
                            .ignoresSafeArea()
                            .cornerRadius(20)
                            .padding()
                }
            }
                        
            
            Text(vm.gameInfo?.name ?? "")
                .bold()
                .padding()
            VStack(alignment: .leading, spacing: 16) {
                Text("About")
                    .bold()
                Button {
                    vm.isViewed.toggle()
                } label: {
                    Text(vm.gameInfo?.descriptionRaw ?? "")
                        .multilineTextAlignment(.leading)
                        .lineLimit(vm.isViewed ? 100 : 7)
                        .foregroundColor(.black)
                }
                Divider()
                
                Text("Released at")
                    .bold()
                Text(vm.gameInfo?.released ?? "")
                
                Divider()
                
                Text("Website")
                    .bold()
                Text(vm.gameInfo?.website ?? "")
                
                Text("Genres")
                    .bold()
                let i = vm.gameInfo?.genres.map({$0.map({$0.name}).compactMap({$0})})
                if let i {
                    Text(i.joined(separator: ", "))
                }
                
            }
            .padding()
            .task {
                            await vm.getGameInfo(id: gameId ?? 0)
//                await vm.getGameInfo(id: 3348)
                
            }
            .alert("Error", isPresented: $vm.isAlert) {
                Button("Cancel", role: .cancel) { }
            } message: {
                Text(vm.errorText)
            }
        }
    }
    
    struct GameDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            GameDetailsView()
        }
    }
}
