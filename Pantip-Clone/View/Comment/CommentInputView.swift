//
//  CommentInputView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct CommentInputView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: CommentViewModel
    @Binding var showCommentInputView: Bool
    @State var selectedImage: UIImage?
    @State var commentImage: Image?
    @State var imagePickerPresented = false
    @State var comment = ""
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .topLeading) {
                           if comment.isEmpty {
                               Text("")
                                   .foregroundColor(Color(UIColor.placeholderText))
                                   .padding(.horizontal, 8)
                                   .padding(.vertical, 16)
                           }
                           
                           TextEditor(text: $comment)
                               .border(.gray)
                               .padding(4)
                       }
                .font(.body)
                .padding()
                
                if commentImage == nil {
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
                        } else if let image = commentImage {
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
                            viewModel.uploadComment(image: image, comment: comment)
                        } else {
                            viewModel.uploadComment(image: nil, comment: comment)
                        }
//                        showCommentInputView.toggle()
                        self.presentationMode.wrappedValue.dismiss()
                        comment = ""
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
                .background(Color(UIColor(named: "background")!))
            }
        }
    }
    
    func loadImage() {
            guard let selectedImage = selectedImage else { return }
            commentImage = Image(uiImage: selectedImage)
        }
}
