//
//  ReplyCommentView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI

struct ReplyCommentView: View {
    @ObservedObject var viewModel: ReplyCommentViewModel
    @State var commentIndex: Int
    var topic: Topic
    var comment: Comment
    
    init(topic: Topic, comment: Comment, commentIndex: Int) {
        viewModel = ReplyCommentViewModel(topic: topic, comment: comment)
        self.commentIndex = commentIndex
        self.topic = topic
        self.comment = comment
    }
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(viewModel.replyComments.indices, id: \.self) { index in
                VStack {
                    ReplyCommentCell(viewModel: ReplyCellViewModel(replyComment: viewModel.replyComments[index], topic: topic, comment: comment), index: index,  commentIndex: commentIndex, topic: viewModel.topic, comment: viewModel.comment)
                }
            }
        }
    }
}
