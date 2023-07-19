//
//  NewsVM.swift
//  level
//
//  Created by Владислав Мазуров on 18.06.23.
//

import Foundation

final class NewsViewModel: ObservableObject {
    
    private let moyaManager: ApiProviderProtocol = ApiManager()
    
    @Published var news: [GameNews] = []
    @Published var isAlert = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    
    func fetchNews() async {
        do {
            let news = try await moyaManager.getNewsRequest()
            await MainActor.run {
                self.news.removeAll()
                self.news.append(contentsOf: news)
            }
        } catch {
            await MainActor.run {
                errorText = error.localizedDescription
            }
        }
    }
}
