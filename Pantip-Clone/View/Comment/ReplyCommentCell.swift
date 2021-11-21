//
//  ReplyCommentCell.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct ReplyCommentCell: View {
    @ObservedObject var viewModel: ReplyCellViewModel
    @State var showReplyInputView = false
    @State var index: Int
    @State var commentIndex: Int
    let topic : Topic
    let comment : Comment
    var didVote: Bool {
        viewModel.replyComment.didVote ?? false
    }
    var didLike: Bool {
        viewModel.replyComment.didLike ?? false
    }
    var user: User {
        viewModel.replyComment.user ?? User(username: "", email: "", fullname: "")
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text("ความคิดเห็นที่ \(commentIndex + 1)-\(index + 1)")
                .foregroundColor(.gray)
                .font(.caption2)
            VStack(alignment: .leading) {
                
                HStack {
                    
                    NavigationLink(destination: ProfileView(viewModel: ProfileViewModel(user: user)).navigationBarTitleDisplayMode(.inline)) {
                        if let imageURL = viewModel.replyComment.profileImageURL {
                            KFImage(URL(string: imageURL))
                                .resizeTo(width: 36, height: 36)
                                .clipShape(Circle())
                                .clipped()
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizeTo(width: 36, height: 36)
                        }

                        VStack(alignment: .leading) {
                            Text(viewModel.replyComment.username)
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .semibold))
                            Text(viewModel.timestamp)
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Button {
                        showReplyInputView.toggle()
                    } label: {
                        Image(systemName: "chevron.down")
                            .padding(4)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke())
                    }
//                    .sheet(isPresented: $showReplyInputView) {
//                        ReplyInputView(viewModel: ReplyCommentViewModel(topic: topic, comment: comment), showReplyInputView: $showReplyInputView)
//                    }
                }
                
                Text(viewModel.replyComment.replyComment)
                    .foregroundColor(.white)
                
                if let imageURL = viewModel.replyComment.imageURL {
                    if imageURL != "" {
                        KFImage(URL(string: imageURL))
                            .resizeTo(width: 250, height: 250)
                            .clipped()
                    }
                }
                
                HStack {
                    Button {
                        didLike ? viewModel.unlike() : viewModel.like()
                    } label: {
                        Image(systemName: didLike ? "face.smiling.fill" : "face.smiling")
                            .foregroundColor(didLike ? .yellow : .gray)
                            .padding(4)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke())
                    }
                    
                    Button {
                        didVote ? viewModel.unvote() : viewModel.vote()
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                                .foregroundColor(didVote ? .yellow : .gray)
                            Text("\(viewModel.replyComment.votes)")
                                .foregroundColor(didVote ? .yellow : .gray)
                        }
                        .padding(4)
                        .padding(.horizontal, 4)
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke())
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: viewModel.replyComment.likes == 0 ? "circle" : "face.smiling")
                                .foregroundColor(viewModel.replyComment.likes != 0 ? .yellow : .gray)
                                .padding(4)
                            Text("\(viewModel.replyComment.likes)")
                        }
                    }
                }
                .foregroundColor(.gray)
            }
            .padding()
            .background(Color(UIColor(named: "reply-cell")!))
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke()
                    .foregroundColor(.gray)
            )
            
            if showReplyInputView {
                CommentInputBox(viewModel: ReplyCommentViewModel(topic: topic, comment: comment), showCommentInputView: $showReplyInputView)
                    .padding(.bottom, 4)
            }
        
        }
        .padding(.horizontal)
        .padding(.leading, 12)
        .padding(.top, 4)
    }
}
