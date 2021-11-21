//
//  CommentInputBox.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 22/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct CommentInputBox: View {
    @ObservedObject var viewModel: ReplyCommentViewModel
    @Binding var showCommentInputView: Bool
    @State var selectedImage: UIImage?
    @State var commentImage: Image?
    @State var imagePickerPresented = false
    @State var replyComment = ""
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color(UIColor(named: "tabbar")!))
                .padding(.bottom, -12)
                .opacity(0.7)
            VStack {
                Text("แสดงความคิดเห็น")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(UIColor(named: "selected-icon")!))
                    .padding()
                ZStack(alignment: .topLeading) {
                           if replyComment.isEmpty {
                               Text("")
                                   .foregroundColor(Color(UIColor.placeholderText))
                                   .padding(.horizontal, 8)
                                   .padding(.vertical, 16)
                           }
                           
                           TextEditor(text: $replyComment)
                               .foregroundColor(.gray)
                               .border(.gray)
                               .padding(4)
                       }
                .font(.body)
                .padding()
                
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
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(UIColor(named: "selected-icon")!))
                    
                    Spacer()
                    
                    Button {
                        viewModel.uploadReplyComment(image: nil, replyComment: replyComment)
                        showCommentInputView.toggle()
                        replyComment = ""
                    } label: {
                         Text("ส่ง")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                            .padding(2)
                            .frame(width: 46)
                            .background(Color.green)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
//
//                .background(Color(UIColor(named: "background")!))
            }
            .padding([.top, .bottom], 8)
            .padding(.horizontal)
        }
    }
    
    func loadImage() {
            guard let selectedImage = selectedImage else { return }
            commentImage = Image(uiImage: selectedImage)
        }
}
