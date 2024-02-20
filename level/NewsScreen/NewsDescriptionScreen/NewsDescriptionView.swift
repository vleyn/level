//
//  NewsDescriptionView.swift
//  level
//
//  Created by Владислав Мазуров on 18.07.23.
//

import SwiftUI

struct NewsDescriptionView: View {
    
    @StateObject var vm = NewsDescriptionViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NewsDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDescriptionView()
    }
}
