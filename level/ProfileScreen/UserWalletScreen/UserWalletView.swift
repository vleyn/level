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
                    .contextMenu {
                        menuItems
                    }
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
                    Color.indigo
                ], startPoint: .topLeading, endPoint: .bottomTrailing))
            VStack(spacing: 10) {
                HStack {
                    TextField("XXXX XXXX XXXX XXXX", text: .init(get: {
                        vm.cardNumber
                    }, set: { value in
                        vm.cardNumberMask(value: value)
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
                        vm.expirationDateMask(value: value)
                    }))
                        .keyboardType(.numberPad)
                        .disabled(vm.shouldHideAddCardButton)

                    SecureField("CVV", text: .init(get: {
                        vm.cvvCode
                    }, set: { value in
                        vm.cvvCodeMask(value: value)
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
            Text(vm.addButtonText)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 16))
        }
        .padding(.horizontal)
        .disabled(vm.checkIsFillCorrectly())
    }
    
    private var menuItems: some View {
            Group {
                Button {
                    vm.addButtonText = "Save"
                    vm.shouldHideAddCardButton = false
                } label: {
                    Text("Edit card info")
                }
                
                Button {
                    vm.deleteUserCard()
                    vm.shouldHideAddCardButton = false
                } label: {
                    Text("Delete this card")
                }
            }
        }
}

struct UserWalletView_Previews: PreviewProvider {
    static var previews: some View {
        UserWalletView()
    }
}
