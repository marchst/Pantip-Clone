//
//  TopicCell.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct TopicCell: View {
    @ObservedObject var viewModel: FeedCellViewModel
    var didVote: Bool {
        viewModel.topic.didVote ?? false
    }
    var didLike: Bool {
        viewModel.topic.didLike ?? false
    }
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Image("\(viewModel.topic.type)")
                    .resizeTo(width: viewModel.topic.type != "conversation" ? 30 : 18, height: viewModel.topic.type != "conversation" ? 30 : 18)
                Text(viewModel.topic.title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.leading , -4)
            }
            
            HStack {
                if let user = viewModel.topic.user {
                    NavigationLink(destination: ProfileView(viewModel: ProfileViewModel(user: user)).navigationBarTitleDisplayMode(.inline)) {
                        if let imageURL = viewModel.topic.ownerImageURL {
                            KFImage(URL(string: imageURL))
                                .resizeTo(width: 36, height: 36)
                                .clipShape(Circle())
                                .clipped()
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizeTo(width: 36, height: 36)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.topic.ownerUsername)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                            Text(viewModel.timestamp)
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(.black)
                    }
                }
                
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .opacity(0)
            }
            
            HStack {
                if let tag1 = viewModel.topic.tags[0] {
                    Text(tag1)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(4)
                        .border(.gray)
                        .opacity(tag1.isEmpty ? 0 : 1)
                }
                if let tag2 = viewModel.topic.tags[1] {
                    Text(tag2)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(4)
                        .border(.gray)
                        .opacity(tag2.isEmpty ? 0 : 1)
                }
                if let tag3 = viewModel.topic.tags[2] {
                    Text(tag3)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(4)
                        .border(.gray)
                        .opacity(tag3.isEmpty ? 0 : 1)
                }
                if let tag4 = viewModel.topic.tags[3] {
                    Text(tag4)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(4)
                        .border(.gray)
                        .opacity(tag4.isEmpty ? 0 : 1)
                }
                if let tag5 = viewModel.topic.tags[4] {
                    Text(tag5)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(4)
                        .border(.gray)
                        .opacity(tag5.isEmpty ? 0 : 1)
                }
            }
            
            Text(viewModel.topic.caption)
                .foregroundColor(.white)
            
            if let imageURL = viewModel.topic.imageURL {
                if !imageURL.isEmpty {
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
                        Text("\(viewModel.topic.votes)")
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
                        Image(systemName: viewModel.topic.likes == 0 ? "circle" : "face.smiling")
                            .foregroundColor(viewModel.topic.likes != 0 ? .yellow : .gray)
                            .padding(4)
                        Text("\(viewModel.topic.likes)")
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
        .background(Color(UIColor(named: "topic-cell")!))
        .padding()
    }
}

//struct TopicCell_Previews: PreviewProvider {
//    static var previews: some View {
//        TopicCell()
//    }
//}

