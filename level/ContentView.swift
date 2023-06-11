//
//  ContentView.swift
//  level
//
//  Created by Владислав Мазуров on 6.06.23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ContentViewModel()
    
    var body: some View {
        VStack {
            Button {
                Task {
//                  await vm.getGameList(page: 1, genres: GameGenres.indie.genreId)
//                  await vm.getGameData(id: 3328)
//                  await vm.login()
//                  await vm.signUpEmail()
//                  vm.currentLoginnedUser()
                    
                }
            } label: {
                Text("Sdelat' vse zaebis")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
