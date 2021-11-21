//
//  MessageChatView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI

struct MessageChatView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var message = ""
    @ObservedObject var viewModel: MessagesViewModel
    @State var showMessageInputView = false
    let user: User
    
    init(user: User) {
        viewModel = MessagesViewModel(user: user)
        self.user = user
    }
    
    @State var scrolled = false
    
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
                
                Circle()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 8)
                    .opacity(0)
                
                
                Spacer()
                
                
                Text(user.username)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(UIColor(named: "selected-icon")!))
                    .padding(.bottom, 8)
                
                Spacer()
                
                Button() {
                    
                } label: {
                    Image("search")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                        .clipped()
                        .opacity(0)
                }
                .disabled(true)
                .padding(.trailing ,8)
                .padding(.bottom, 8)
                
                Button {
                    
                } label: {
                    Image("new_topic")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                        .opacity(0)
                        .clipped()
                }
                .disabled(true)
                .padding(8)
                .padding(.bottom, 8)
                
            }
            .background(Color(UIColor(named: "tabbar")!))
        VStack {
            ScrollViewReader { reader in
                ScrollView {
                    VStack {
                        if viewModel.messages.count == 0 {
                            HStack {
                                Spacer()
                                Text("ไม่มีข้อความ")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding()
                                Spacer()
                            }
                        }
                        ForEach(viewModel.messages) { message in
                            MessageRowView(message: message)
                                .onAppear {
                                    if message.id == viewModel.messages.last?.id && !scrolled {
                                        reader.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                                    }
                                }
                        }
                        .onChange(of: viewModel.messages) { _ in
                            reader.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            Button {
                showMessageInputView.toggle()
            } label: {
                Text("พิมพ์ข้อความ...")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(UIColor(named: "selected-icon")!))
                    .padding()
                    
            }
            .padding(.horizontal, 24)
            .background(Color(UIColor(named: "comment")!))
            .border(.gray)
            .foregroundColor(.black)
            
//            MessageInputView(message: $message, action: sendMessage)
        }
        .background(Color(UIColor(named: "background")!))
        .sheet(isPresented: $showMessageInputView) {
            MessageInputView(viewModel: viewModel, showMessageInputView: $showMessageInputView)
        }
        }
    }
    
    func sendMessage() {
        viewModel.sendMessage(image: nil, title: "", message: message)
        message = ""
    }
}
