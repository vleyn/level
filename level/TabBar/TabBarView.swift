//
//  CustomTabbar.swift
//  level
//
//  Created by Владислав Мазуров on 15.06.23.
//

import SwiftUI
import Kingfisher

struct TabBarView: View {
    
    @StateObject var vm = TabBarViewModel()
    
    var body: some View {
        TabView {
            NavigationStack { HomeView() }
            .tabItem {
                Image(systemName: "house")
            }
            NavigationStack { NewsView() }
            .tabItem {
                Image(systemName: "newspaper")
            }
            NavigationStack { MessagesView() }
            .tabItem {
                Image(systemName: "message")
            }
            NavigationStack { ProfileView() }
            .tabItem {
                Image(systemName: "person")
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
    }
}

struct CustomTabbar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
