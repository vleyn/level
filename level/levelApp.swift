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
        
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
     }
    
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "isAuthorized") {
                CustomTabbar()
                    .onAppear()
            } else {
                LoginView()
            }
        }
    }
}

extension levelApp {
  private func setupAuthentication() {
    FirebaseApp.configure()
  }
}
