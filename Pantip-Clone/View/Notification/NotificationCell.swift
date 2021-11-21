//
//  NotificationCell.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 13/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    @ObservedObject var viewModel: NotificationsCellViewModel
    
    var body: some View {
        VStack {
                if let topic = viewModel.notification.topic {
                    NavigationLink(destination: TopicView(viewModel: FeedCellViewModel(topic: topic)).navigationBarTitleDisplayMode(.inline)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color(UIColor(named: "tabbar")!))
                                .opacity(0.5)
                            HStack {
                                if let imageURL = viewModel.notification.profileImageURL {
                                    KFImage(URL(string: imageURL))
                                        .resizeTo(width: 40, height: 40)
                                        .clipShape(Circle())
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizeTo(width: 40, height: 40)
                                        .clipShape(Circle())
                                }
                                
                                Text(viewModel.notification.username)
                                    .font(.system(size: 14, weight: .semibold))
                                +
                                Text(viewModel.notification.type.notificationMessage)
                                    .font(.system(size: 15))
                                +
                                Text(" \(viewModel.timestamp)")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                
                                Spacer ()
                            }
                            .padding(.horizontal)
                            .padding(4)
                            .padding(.top, 4)
                        }
                    }
                }
            
        }
        .padding()
    }
}


