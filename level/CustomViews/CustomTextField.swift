//
//  CustomTextField.swift
//  level
//
//  Created by Владислав Мазуров on 14.06.23.
//

import SwiftUI

struct CustomTextField: View {

    @Binding var bindingValue: String
    var image: String
    var placeHolder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                TextField(placeHolder, text: $bindingValue)
                    .padding(.leading, 45)
                    .padding([.top, .bottom], 13)
                    .textFieldStyle(.automatic)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(20)
                Image(systemName: image)
                    .padding(.leading)
                    .foregroundColor(.gray)
            }
        }
        .padding([.leading, .trailing])
    }
}

struct CustomSecureTextField: View {

    @Binding var bindingValue: String
    var image: String
    var placeHolder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                SecureField(placeHolder, text: $bindingValue)
                    .padding(.leading, 45)
                    .padding([.top, .bottom], 13)
                    .textFieldStyle(.automatic)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(20)
                Image(systemName: image)
                    .padding(.leading)
                    .foregroundColor(.gray)
            }
        }
        .padding([.leading, .trailing])
    }
}
