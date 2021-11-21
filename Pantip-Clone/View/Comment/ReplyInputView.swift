//
//  ReplyInputView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct ReplyInputView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: ReplyCommentViewModel
    @Binding var showReplyInputView: Bool
    @State var selectedImage: UIImage?
    @State var replyCommentImage: Image?
    @State var imagePickerPresented = false
    @State var replyComment = ""
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .topLeading) {
                           if replyComment.isEmpty {
                               Text("")
                                   .foregroundColor(Color(UIColor.placeholderText))
                                   .padding(.horizontal, 8)
                                   .padding(.vertical, 16)
                           }
                           
                           TextEditor(text: $replyComment)
                               .border(.gray)
                               .padding(4)
                       }
                .font(.body)
                .padding()
                
                if replyCommentImage == nil {
                            Button(action: {
                                imagePickerPresented.toggle()
                            }) {
                                Image(systemName: "plus.circle")
                                    .resizeTo(width: 30, height: 30)
                                    .padding(.top)
                                    .foregroundColor(.black)
                            }
                            .sheet(isPresented: $imagePickerPresented) {
                                loadImage()
                            } content: {
                                ImagePicker(image: $selectedImage)
                            }
                        } else if let image = replyCommentImage {
                            VStack {
                                HStack(alignment: .top) {
                                    image.resizeTo(width: 96, height: 96)
                                        .clipped()
                                }
                                .padding()
                            }
                        }
                
                HStack {
                    
                    if let imageURL = AuthViewModel.shared.getInfo(type: "imageURL")! {
                        KFImage(URL(string: imageURL))
                            .resizeTo(width: 24, height: 24)
                            .clipShape(Circle())
                            .clipped()
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizeTo(width: 24, height: 24)
                    }
                    
                    Text(AuthViewModel.shared.getInfo(type: "username")!)
                    
                    Spacer()
                    
                    Button {
                        if let image = selectedImage {
                            viewModel.uploadReplyComment(image: image, replyComment: replyComment)
                        } else {
                            viewModel.uploadReplyComment(image: nil, replyComment: replyComment)
                        }
//                        showReplyInputView.toggle()
                        self.presentationMode.wrappedValue.dismiss()
                        replyComment = ""
                    } label: {
                         Text("ส่ง")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 46)
                            .background(Color.green)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke()
                                    .foregroundColor(.gray)
                            )
                    }
                }
                .padding(.horizontal)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("แสดงความคิดเห็น")
            }
        }
    }
    
    func loadImage() {
            guard let selectedImage = selectedImage else { return }
            replyCommentImage = Image(uiImage: selectedImage)
        }
}

