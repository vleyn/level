//
//  UserWalletView.swift
//  level
//
//  Created by Владислав Мазуров on 7.07.23.
//

import SwiftUI

struct UserWalletView: View {
    
    @StateObject var vm = UserWalletViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                cardView
                Spacer()
                if !vm.shouldHideAddCardButton {
                    addCardButton
                }
            }
            .navigationTitle("Add card")
        }
        .task {
            vm.fetchUserCard()
        }
        .refreshable {
            vm.fetchUserCard()
        }
    }
    
    private var cardView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(colors: [
                    Color.gray,
                    Color.blue
                ], startPoint: .topLeading, endPoint: .bottomTrailing))
            VStack(spacing: 10) {
                HStack {
                    TextField("XXXX XXXX XXXX XXXX", text: .init(get: {
                        vm.cardNumber
                    }, set: { value in
                        vm.cardNumber = ""
                        let startIndex = value.startIndex
                        for index in 0..<value.count {
                            let stringIndex = value.index(startIndex, offsetBy: index)
                            vm.cardNumber += String(value[stringIndex])
                            
                            if (index + 1) % 5 == 0 && value[stringIndex] != " " {
                                vm.cardNumber.insert(" ", at: stringIndex)
                            }
                        }
                        if value.last == " " {
                            vm.cardNumber.removeLast()
                        }
                        vm.cardNumber = String(vm.cardNumber.prefix(19))
                    }))
                        .font(.title3)
                        .keyboardType(.numberPad)
                        .disabled(vm.shouldHideAddCardButton)
                    Image("visa.logo")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                }
                .padding(.top)
                Spacer()
                HStack(spacing: 12) {
                    TextField("MM/YY", text: .init(get: {
                        vm.expireDate
                    }, set: { value in
                        vm.expireDate = value
                        if value.count == 3 && !value.contains("/") {
                            let startIndex = value.startIndex
                            let thirdPosition = value.index(startIndex, offsetBy: 2)
                            vm.expireDate.insert("/", at: thirdPosition)
                        }
                        
                        if value.last == "/" {
                            vm.expireDate.removeLast()
                        }
                        vm.expireDate = String(vm.expireDate.prefix(5))
                    }))
                        .keyboardType(.numberPad)
                        .disabled(vm.shouldHideAddCardButton)

                    SecureField("CVV", text: .init(get: {
                        vm.cvvCode
                    }, set: { value in
                        vm.cvvCode = value
                        vm.cvvCode = String(vm.cvvCode.prefix(3))
                    }))
                        .frame(width: 35)
                        .keyboardType(.numberPad)
                        .disabled(vm.shouldHideAddCardButton)

                    Image(systemName: "questionmark.circle.fill")
                }
                Spacer()
                
                TextField("CARDHOLDER NAME", text: $vm.cardHolderName)
                    .disabled(vm.shouldHideAddCardButton)
            }
            .padding(.horizontal)
            .padding(.vertical, 35)
        }
        .padding()
        .frame(height: 270)
    }
    
    private var addCardButton: some View {
        Button {
            vm.addUserCard()
        } label: {
            Text("Add this card")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 16))
        }
        .padding(.horizontal)
        .disabled(vm.cardNumber.count != 19 || vm.expireDate.count != 5 || vm.cardHolderName.isEmpty || vm.cvvCode.count != 3)
    }
}

struct UserWalletView_Previews: PreviewProvider {
    static var previews: some View {
        UserWalletView()
    }
}
