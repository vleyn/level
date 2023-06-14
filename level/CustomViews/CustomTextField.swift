//
//  CustomTextField.swift
//  level
//
//  Created by Владислав Мазуров on 14.06.23.
//

import SwiftUI

struct CustomTextField: View {

    @Binding var bindingValue: String
    var headerText: String
    var placeHolder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(headerText)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.leading)
            TextField(placeHolder, text: $bindingValue)
                .padding(.leading, 25)
                .padding([.top, .bottom], 15)
                .textFieldStyle(.automatic)
                .background(.gray.opacity(0.1))
                .cornerRadius(18)
        }
        .padding([.leading, .trailing])
    }
}

struct CustomSecureTextField: View {

    @Binding var bindingValue: String
    var headerText: String
    var placeHolder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(headerText)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.leading)
            SecureField(placeHolder, text: $bindingValue)
                .padding(.leading, 25)
                .padding([.top, .bottom], 15)
                .textFieldStyle(.automatic)
                .background(.gray.opacity(0.1))
                .cornerRadius(18)
        }
        .padding([.leading, .trailing])
    }
}
