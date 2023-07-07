//
//  CustomTabbar.swift
//  level
//
//  Created by Владислав Мазуров on 15.06.23.
//

import SwiftUI
import Kingfisher

struct CustomTabbar: View {
    
    @StateObject var vm = CustomTabbarViewModel()
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
            }
            NavigationStack {
                NewsView()
            }
            .tabItem {
                Image(systemName: "play.circle")
            }
            NavigationStack {
                MessagesView()
            }
            .tabItem {
                Image(systemName: "house")
            }
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "heart")
            }
        }
        .task {
            vm.cacheUser()
        }
        .alert("Error", isPresented: $vm.isAlert) {
            Button("Cancel", role: .cancel) { }
        } message: {
            Text(vm.errorText)
        }
        .navigationTitle("Test")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CustomTabbar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabbar()
    }
}
