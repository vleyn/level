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
                print("request")
                Task {
                    try await vm.getListGames(page: 3)
//                    try await vm.getGameData(id: 3328)
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
