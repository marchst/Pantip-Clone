//
//  ProfileButtonView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI

struct ProfileButtonView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        if !viewModel.user.isCurrentUser {
            HStack(spacing: 16) {
                if let user = viewModel.user {
                    NavigationLink(destination: MessageChatView(user: user)) {
                        Text("Message")
                            .font(.system(size: 14, weight: .semibold))
                            .frame(width: 172, height: 32)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                }
            }
        }
    }
}
