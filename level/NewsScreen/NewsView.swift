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
        Image(systemName: "playstation.logo")
    }
    
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
