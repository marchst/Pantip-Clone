//
//  FeedCell.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    @ObservedObject var viewModel: FeedCellViewModel
    @ObservedObject var countViewModel: CountCommentViewModel 
    
    init(topic: Topic, viewModel: FeedCellViewModel) {
        countViewModel = CountCommentViewModel(topic: topic)
        self.viewModel = viewModel
    }
    var body: some View {
        NavigationLink(destination: TopicView(viewModel: viewModel).navigationBarTitleDisplayMode(.inline)) {
        VStack(alignment: .leading) {
            HStack() {
                if let imageURL = viewModel.topic.imageURL {
                    if !imageURL.isEmpty {
                        KFImage(URL(string: imageURL))
                            .resizeTo(width: 62, height: 62)
                            .clipped()
                    }
                }
                
                Image("\(viewModel.topic.type)")
                    .resizeTo(width: viewModel.topic.type != "conversation" ? 38 : 26, height: viewModel.topic.type != "conversation" ? 38 : 26)
                    .padding(.leading, viewModel.topic.type == "conversation" ? 4 : 0)
                Text(viewModel.topic.title)
                    .foregroundColor(Color(UIColor(named: "selected-icon")!))
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.leading, viewModel.topic.type != "conversation" ? -8 : -2)
            }
            
            HStack {
                Text(viewModel.topic.ownerUsername)
                    .foregroundColor(Color(UIColor(named: "userid")!))
                    .font(.system(size: 14, weight: .semibold))
                Text(viewModel.timestamp)
                    .foregroundColor(Color(UIColor(named: "timeNcomment")!))
                    .font(.system(size: 14, weight: .semibold))
                
                Spacer()
                
                Image("comments")
                    .foregroundColor(Color(UIColor(named: "timeNcomment")!))
                Text("\(countViewModel.getCount())")
                    .foregroundColor(Color(UIColor(named: "timeNcomment")!))
                    .font(.system(size: 14, weight: .semibold))
            }
            //                    .padding(.horizontal)
        }
        }
    }
}

