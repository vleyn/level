//
//  levelApp.swift
//  level
//
//  Created by Владислав Мазуров on 6.06.23.
//

import SwiftUI
import FirebaseCore

@main
struct levelApp: App {
    
    init() {
       setupAuthentication()
     }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension levelApp {
  private func setupAuthentication() {
    FirebaseApp.configure()
  }
}
