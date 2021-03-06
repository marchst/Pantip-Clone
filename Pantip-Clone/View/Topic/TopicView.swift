//
//  TopicView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI

struct TopicView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: FeedCellViewModel
    @State var showCommentInputView = false
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                        .padding(8)
                        .padding(.bottom, 8)
                }
                
                
                Spacer()
                
                
                Text("พันทิป")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(UIColor(named: "selected-icon")!))
                    .padding(.bottom, 8)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image("new_topic")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                        .clipped()
                        .opacity(0)
                }
                .disabled(true)
                .padding(8)
                .padding(.bottom, 8)
                
            }
            .background(Color(UIColor(named: "tabbar")!))
            
            ScrollView {
                VStack {
                    TopicCell(viewModel: viewModel)
                    CommentView(viewModel: CommentViewModel(topic: viewModel.topic))
                }
            }
            .background(Color(UIColor(named: "background")!))
            HStack {
                Spacer()
                Button {
                    showCommentInputView.toggle()
                } label: {
                    HStack {
                        Spacer()
                        Text("แสดงความคิดเห็น")
                            .font(.system(size: 18, weight: .semibold))
                            .padding()
                        Spacer()
                    }
                }
                .border(.gray)
                .foregroundColor(.gray)
                Spacer()
                
            }
            .background(Color(UIColor(named: "comment")!))
            .sheet(isPresented: $showCommentInputView) {
                CommentInputView(viewModel: CommentViewModel(topic: viewModel.topic), showCommentInputView: $showCommentInputView)
            }
            .navigationBarHidden(true)
        }
    }
}

