//
//  NewsView.swift
//  level
//
//  Created by Владислав Мазуров on 18.06.23.
//

import SwiftUI
import AVKit

struct NewsView: View {
    
    @StateObject var vm = NewsViewModel()
    
    var body: some View {
        ZStack {
            Image("backgroundPhoto")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    ForEach(vm.news, id: \.id) { news in
                        NavigationLink {
                            //
                        } label: {
                            NewsCell(news: news)
                        }
                    }
                }
            }
            .refreshable {
                await vm.fetchNews()
            }
        }
        .task {
            await vm.fetchNews()
        }
        .alert("Error", isPresented: $vm.isAlert) {
            Button("Cancel", role: .cancel) { }
        } message: {
            Text(vm.errorText)
        }
        .navigationTitle("News")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
