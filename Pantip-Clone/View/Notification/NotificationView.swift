//
//  NotificationView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 11/11/2564 BE.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var viewModel = NotificationsViewModel()
    @State var user: User
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HeaderView(user: user,viewModel: ProfileViewModel(user: user), selectedIndex: .constant(2), searchText: .constant(""), inSearchMode: .constant(false))
                ScrollView {
                    if viewModel.notifications.count == 0 {
                        HStack {
                            Spacer()
                            Text("ไม่มีการแจ้งเตือน")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .semibold))
                                .padding()
                            Spacer()
                        }
                    }
                    ForEach(viewModel.notifications) { notification in
                        NotificationCell(viewModel: NotificationsCellViewModel(notification: notification))
                    }
                }
                .background(Color(UIColor(named: "background")!))
            }
            .background(Color(UIColor(named: "background")!))
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        
    }
}

