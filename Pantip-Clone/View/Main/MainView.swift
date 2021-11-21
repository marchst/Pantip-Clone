//
//  MainView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 11/11/2564 BE.
//

import SwiftUI

struct MainView: View {
    @State var user: User
    @Binding var selectedIndex: Int
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            FeedView(user: user)
                .onAppear {
                    selectedIndex = 0
                }
                .tabItem {
                    selectedIndex == 0 ? Image("home_fill") : Image("home")
                }
                .tag(0)
            
            TagView(user: user)
                .onTapGesture {
                    selectedIndex = 1
                }
                .tabItem {
                    selectedIndex == 1 ? Image("ballot_fill") : Image("ballot")
                }
                .tag(1)
            
            NotificationView(user: user)
                .onTapGesture {
                    selectedIndex = 2
                }
                .tabItem {
                    selectedIndex == 2 ? Image("bell_fill") : Image("bell")
                }
                .tag(2)
            
            MessagesView(currentUser: user)
                .onTapGesture {
                    selectedIndex = 3
                }
                .tabItem {
                    selectedIndex == 3 ? Image("email_fill") : Image("email")
                }
                .tag(3)
            
            MenuView(user: user)
                .onTapGesture {
                    selectedIndex = 4
                }
                .tabItem {
                    Image("menu")
                }
                .tag(4)
        }
        .accentColor(Color(UIColor(named: "selected-icon")!))
    }
}
