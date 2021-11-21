//
//  MenuView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 11/11/2564 BE.
//

import SwiftUI

struct MenuView: View {
    @State var user: User
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HeaderView(user: user,viewModel: ProfileViewModel(user: user), selectedIndex: .constant(4), searchText: .constant(""), inSearchMode: .constant(false))
                VStack(spacing: 0) {
                    ScrollView {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color(UIColor(named: "tabbar")!))
                                .opacity(0.5)
                            Button {
                                AuthViewModel.shared.signOut()
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("ออกจากระบบ")
                                        .foregroundColor(Color(UIColor(named: "selected-icon")!))
                                        .opacity(0.8)
                                        .font(.system(size: 22, weight: .semibold))
                                    Spacer()
                                }
                                .foregroundColor(.black)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                            }
                            .padding()
                        }
                        .padding()
                            
                            
                        
                    }
                    .background(Color(UIColor(named: "background")!))
                    
                    HStack {
                        Text("เวอร์ชัน 3.6.2")
                            .font(.system(size: 14, weight: .semibold))
                        
                        Spacer()
                        
                        Text("ติดตามพันทิป")
                            .font(.system(size: 14, weight: .semibold))
                        Rectangle()
                            .frame(width: 14, height: 14)
                        Rectangle()
                            .frame(width: 14, height: 14)
                    }
                    .padding()
                    .foregroundColor(.gray)
                    .background(Color(UIColor(named: "background")!))
                }
            }
            
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        
    }
}


