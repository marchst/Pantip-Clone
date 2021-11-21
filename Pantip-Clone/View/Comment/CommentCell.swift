//
//  CommentCell.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct CommentCell: View {
    @ObservedObject var viewModel: CommentCellViewModel
    @State var showReplyInputView = false
    @State var index: Int
    let topic : Topic
    var didVote: Bool {
        viewModel.comment.didVote ?? false
    }
    var didLike: Bool {
        viewModel.comment.didLike ?? false
    }
    var user: User {
        viewModel.comment.user ?? User(username: "", email: "", fullname: "")
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text("ความคิดเห็นที่ \(index + 1)")
                .font(.caption2)
                .foregroundColor(.gray)
            VStack(alignment: .leading) {
                
                HStack {
                    NavigationLink(destination: ProfileView(viewModel: ProfileViewModel(user: user)).navigationBarTitleDisplayMode(.inline)) {
                        if let imageURL = viewModel.comment.profileImageURL {
                            KFImage(URL(string: imageURL))
                                .resizeTo(width: 36, height: 36)
                                .clipShape(Circle())
                                .clipped()
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizeTo(width: 36, height: 36)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.comment.username)
                                
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
                        showReplyInputView = true
                    } label: {
                        Image(systemName: "chevron.down")
                            .padding(4)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke())
                    }
                    .sheet(isPresented: $showReplyInputView) {
                        ReplyInputView(viewModel: ReplyCommentViewModel(topic: topic, comment: viewModel.comment), showReplyInputView: $showReplyInputView)
                    }
                }
                
                Text(viewModel.comment.comment)
                    .foregroundColor(.white)
                
                if let imageURL = viewModel.comment.imageURL {
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
                                .foregroundColor(didVote ? .yellow : .blue)
                            Text("\(viewModel.comment.votes)")
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
                            Image(systemName: viewModel.comment.likes == 0 ? "circle" : "face.smiling")
                                .foregroundColor(viewModel.comment.likes != 0 ? .yellow : .gray)
                                .padding(4)
                            Text("\(viewModel.comment.likes)")
                        }
                    }
                }
                .foregroundColor(.gray)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke()
                    .foregroundColor(.gray)
            )
            .background(Color(UIColor(named: "comment-cell")!))
        
        }
        
        .padding(.horizontal)
        .padding(.top, 4)
    }
}

