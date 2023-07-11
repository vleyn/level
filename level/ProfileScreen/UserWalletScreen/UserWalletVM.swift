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
        Task {
            let card = CardModel(id: firebaseManager.auth.currentUser?.uid ?? "", cardNumber: cardNumber, expirationDate: expireDate, cvvCode: cvvCode, cardholderName: cardHolderName, balance: 0)
            firebaseManager.databaseWriteCard(card: card)
        }
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
}
