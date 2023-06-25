//
//  CustomTabbar.swift
//  level
//
//  Created by Владислав Мазуров on 15.06.23.
//

import SwiftUI
import Kingfisher

struct CustomTabbar: View {
    
    @State var selectedTab = "Home"
    let tabs = ["Home", "News", "Messenger", "Profile"]
    @StateObject var vm = CustomTabbarViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag("Home")
                NewsView()
                    .tag("News")
                MessagesView()
                    .tag("Messenger")
                ProfileView()
                    .tag("Profile")
            }
            
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    Spacer()
                    TabbarItem(tab: tab, selected: $selectedTab)
                    Spacer()
                }
            }
            .padding(.top, 15)
            .padding(.bottom, 5)
            .frame(maxWidth: .infinity)
            .background(Color(.lightGray))
        }
        .task {
            vm.cacheUser()
        }
    }
}

struct TabbarItem: View {
    @State var tab: String
    @Binding var selected: String
    @StateObject var vm = CustomTabbarViewModel()
    
    var body: some View {
        if tab == "Profile" {
            Button {
                withAnimation(.spring()) {
                    selected = tab
                    vm.cacheUser()
                }
                
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 43, height: 43)
                        .foregroundColor(selected == tab ? Color.white : Color.gray)
                    if vm.avatar.isEmpty {
                        Image("avatar")
                            .resizable()
                            .frame(width: 35, height: 35)
                    } else {
                        KFImage(URL(string: UserCache.shared.avatar))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 35, height: 35)
                            .clipped()
                            .cornerRadius(17)
                            .overlay(RoundedRectangle(cornerRadius: 17)
                            .stroke(Color(.label), lineWidth: 1))
                            .shadow(radius: 5)
                    }
                }
            }
        } else {
            ZStack {
                Button {
                    withAnimation(.spring()) {
                        selected = tab
                    }
                } label: {
                    HStack {
                        Image(tab)
                            .resizable()
                            .frame(width: 20, height: 20)
                        if selected == tab {
                            Text(tab)
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .opacity(selected == tab ? 1 : 0.7)
            .padding(.vertical, 10)
            .padding(.horizontal, 17)
            .background(selected == tab ? .white : .gray)
            .clipShape(Capsule())
        }
    }
}

struct CustomTabbar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabbar()
    }
}
