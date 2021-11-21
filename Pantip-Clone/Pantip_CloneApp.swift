//
//  Pantip_CloneApp.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 11/11/2564 BE.
//

import SwiftUI
import Firebase

@main
struct Pantip_CloneApp: App {
    init() {
           FirebaseApp.configure()
       }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthViewModel.shared)
        }
    }
}
