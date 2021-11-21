//
//  OwnTopicListView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 19/11/2564 BE.
//

import SwiftUI

struct OwnTopicListView: View {
    @ObservedObject var viewModel = FeedViewModel()
    var body: some View {
        
        ScrollView {
            ForEach(viewModel.filterTopic(withUid: AuthViewModel.shared.getUID()!)) { topic in
                
                NavigationLink {
                    TopicView(viewModel: FeedCellViewModel(topic: topic)).navigationBarTitleDisplayMode(.inline)
                } label: {
                    VStack(alignment: .leading) {
                        Text(topic.title)
                        
                        HStack {
                            Text(topic.ownerUsername)
                                .font(.caption2)
//                            Text(topic.timestampText())
//                                .font(.caption2)
                            Spacer()
    //                        Image("comments")
    //                            .resizable()
    //                            .frame(width: 14, height: 14)
    //                        Text("1")
    //                            .font(.caption2)
                        }
                    }
                    .padding()
                }

                
            }
        }
        .background(Color(UIColor(named: "tabbar")!))
    }
}

struct OwnTopicListView_Previews: PreviewProvider {
    static var previews: some View {
        OwnTopicListView()
    }
}
