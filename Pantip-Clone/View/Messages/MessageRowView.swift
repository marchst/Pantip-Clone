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
        HStack(spacing: 15) {
            if !ownAccount {
                if let imageURL = message.ownerImageURL {
                    KFImage(URL(string: imageURL))
                        .resizeTo(width: 50, height: 50)
                        .clipped()
                        .clipShape(Circle())
                }
            }
            
            if ownAccount {
                Spacer(minLength: 0)
            }
            
            VStack(spacing: 5) {
                Text(message.message)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(UIColor(named: "topic-cell")!))
//                    .clipShape(MessageBubble(ownAccount: ownAccount))
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                
                Text(message.timestampText())
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(ownAccount ? .trailing : .leading, 10)
            }
            
            if !ownAccount {
                Spacer(minLength: 0)
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
        .padding()
    }
}
