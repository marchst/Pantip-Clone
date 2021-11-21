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
                VStack {
                    ScrollView {
                        VStack {
                            HStack {
                                Rectangle()
                                    .frame(width: 24, height: 24)
                                Text("เมนู")
                                Spacer()
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            
                            HStack {
                                Rectangle()
                                    .frame(width: 24, height: 24)
                                Text("เมนู")
                                Spacer()
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            
                            HStack {
                                Rectangle()
                                    .frame(width: 24, height: 24)
                                Text("เมนู")
                                Spacer()
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            
                            Button {
                                AuthViewModel.shared.signOut()
                            } label: {
                                HStack {
                                    Rectangle()
                                        .frame(width: 24, height: 24)
                                    Text("ออกจากระบบ")
                                    Spacer()
                                }
                                .foregroundColor(.black)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                            }
                            
                        }
                    }
                    
                    HStack {
                        Text("เวอร์ชัน 3.6.2")
                        
                        Spacer()
                        
                        Text("ติดตามพันทิป")
                        Rectangle()
                            .frame(width: 14, height: 14)
                        Rectangle()
                            .frame(width: 14, height: 14)
                    }
                    .padding(.horizontal)
                    .foregroundColor(.gray)
                }
                .background(Color(UIColor(named: "background")!))
            }
            
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        
    }
}


