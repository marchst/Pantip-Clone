//
//  MessageRowView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct MessageRowView: View {
    let message: Message
    
    var ownAccount: Bool {
        message.senderID == AuthViewModel.shared.userSession?.uid
    }
    
    var body: some View {
        VStack(alignment: .leading) {
        HStack {
            VStack {
                if !ownAccount {
                    if let imageURL = message.ownerImageURL {
                        KFImage(URL(string: imageURL))
                            .resizeTo(width: 50, height: 50)
                            .clipped()
                            .clipShape(Circle())
                    }
                }
                
                if ownAccount {
                    if let imageURL = message.ownerImageURL {
                        KFImage(URL(string: imageURL))
                            .resizeTo(width: 50, height: 50)
                            .clipped()
                            .clipShape(Circle())
                    }
                }
            }
            VStack {
                Text(message.message)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                
                Text(message.timestampText())
                    .font(.caption2).bold()
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }
            Spacer()
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 3).stroke().foregroundColor(.gray))
        .background(Color(UIColor(named: "topic-cell")!))
        }
        .padding(6)
    }
}
