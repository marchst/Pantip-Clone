//
//  MessageCell.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 13/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct MessageCell: View {
    let user: User
    var body: some View {
        HStack {
            if let imageURL = user.profileImageURL {
                KFImage(URL(string: imageURL))
                    .resizeTo(width: 72, height: 72)
                    .clipShape(Circle())
                    .clipped()
            } else {
                Circle()
                    .foregroundColor(.gray)
                    .frame(width: 72, height: 72)
            }
            
            VStack(alignment: .leading) {
                Text(user.username)
                    .font(.title).bold()
                Text(user.fullname)
                    .font(.caption).bold()
            }
            .padding(.horizontal)
            Spacer()
            
        }
        .background(Color(UIColor(named: "background")!))
        .padding(18)
    }
}
