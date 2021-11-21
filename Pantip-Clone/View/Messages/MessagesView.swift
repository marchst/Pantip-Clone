//
//  MessagesView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 11/11/2564 BE.
//

import SwiftUI

struct MessagesView: View {
    @State var message = ""
    let currentUser: User
    @ObservedObject var viewModel = UserMessageViewModel()
       
    @State var scrolled = false
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HeaderView(user: currentUser,viewModel: ProfileViewModel(user: currentUser), selectedIndex: .constant(3), searchText: .constant(""), inSearchMode: .constant(false))
                ScrollView {
                    if viewModel.users.count != 0 {
                        ForEach(viewModel.users) { user in
                            if currentUser.username != user.username {
                                NavigationLink(destination: MessageChatView(user: user).navigationBarHidden(true)) {
                                    MessageCell(user: user)
                                }
                            }
                            
                        }
                    } else {
                        HStack {
                            Spacer()
                            Text("ไม่มีข้อความ")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .semibold))
                                .padding()
                            Spacer()
                        }
                    }
                }
                .background(Color(UIColor(named: "background")!))
            }
            
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        
    }
}
