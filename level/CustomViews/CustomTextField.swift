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
                TextField(text: $bindingValue) {
                    Text(placeHolder)
                        .foregroundColor(.black.opacity(0.6))
                }
                    .padding(.leading, 45)
                    .padding(.vertical, 13)
                    .textFieldStyle(.automatic)
                    .background(.white.opacity(0.6))
                    .foregroundColor(.black)
                    .cornerRadius(20)
                Image(systemName: image)
                    .padding(.leading)
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal)
    }
}

struct CustomSecureTextField: View {

    @Binding var bindingValue: String
    var image: String
    var placeHolder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                SecureField(text: $bindingValue) {
                    Text(placeHolder)
                        .foregroundColor(.black.opacity(0.6))
                }
                    .padding(.leading, 45)
                    .padding(.vertical, 13)
                    .textFieldStyle(.automatic)
                    .background(.white.opacity(0.6))
                    .foregroundColor(.black)
                    .cornerRadius(20)
                Image(systemName: image)
                    .padding(.leading)
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal)
    }
}
