//
//  EditProfileView.swift
//  level
//
//  Created by Владислав Мазуров on 18.06.23.
//

import SwiftUI

struct EditProfileView: View {
    
    @StateObject var vm = EditProfileViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
