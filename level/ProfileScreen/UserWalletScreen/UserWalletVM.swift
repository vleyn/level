//
//  UserWalletVM.swift
//  level
//
//  Created by Владислав Мазуров on 11.07.23.
//

import Foundation
import SwiftUI

final class UserWalletViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseProtocol = FirebaseManager()
    
    @Published var cardNumber: String = ""
    @Published var expireDate: String = ""
    @Published var cvvCode: String = ""
    @Published var cardHolderName: String = ""
    @Published var shouldHideAddCardButton: Bool = false

    func addUserCard() {
        shouldHideAddCardButton = true
        let card = CardModel(id: firebaseManager.auth.currentUser?.uid ?? "", cardNumber: cardNumber, expirationDate: expireDate, cvvCode: cvvCode, cardholderName: cardHolderName, balance: 0)
        firebaseManager.databaseWriteCard(card: card)
    }
    
    func fetchUserCard() {
        Task {
            do {
                let card = try await firebaseManager.databaseReadCards(uid: UserCache.shared.uid)
                await MainActor.run {
                    cardNumber = card.cardNumber
                    expireDate = card.expirationDate
                    cvvCode = card.cvvCode
                    cardHolderName = card.cardholderName
                }
            } catch {
                
            }
        }
    }
    
    func cardNumberMask(value: String) {
        cardNumber = ""
        let startIndex = value.startIndex
        for index in 0..<value.count {
            let stringIndex = value.index(startIndex, offsetBy: index)
            cardNumber += String(value[stringIndex])
            
            if (index + 1) % 5 == 0 && value[stringIndex] != " " {
                cardNumber.insert(" ", at: stringIndex)
            }
        }
        if value.last == " " {
            cardNumber.removeLast()
        }
        cardNumber = String(cardNumber.prefix(19))
    }
    
    func expirationDateMask(value: String) {
        expireDate = value
        if value.count == 3 && !value.contains("/") {
            let startIndex = value.startIndex
            let thirdPosition = value.index(startIndex, offsetBy: 2)
            expireDate.insert("/", at: thirdPosition)
        }
        
        if value.last == "/" {
            expireDate.removeLast()
        }
        expireDate = String(expireDate.prefix(5))
    }
    
    func cvvCodeMask(value: String) {
        cvvCode = value
        cvvCode = String(cvvCode.prefix(3))
    }
    
    func checkIsFillCorrectly() -> Bool {
        cardNumber.count != 19 || expireDate.count != 5 || cardHolderName.isEmpty || cvvCode.count != 3
    }
}
