//
//  CommentView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var viewModel: CommentViewModel
    
    init(topic: Topic) {
        viewModel = CommentViewModel(topic: topic)
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(viewModel.comments.count) ความคิดเห็น")
                .font(.caption2)
                .foregroundColor(.gray)
                .padding(.leading)
            ForEach(viewModel.comments.indices, id: \.self) { index in
                VStack {
                    CommentCell(viewModel: CommentCellViewModel(comment: viewModel.comments[index]), index: index, topic: viewModel.topic)
                    ReplyCommentView(topic: viewModel.topic, comment: viewModel.comments[index], commentIndex: index)
                }
            }
        }
    }
}
