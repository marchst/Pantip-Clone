//
//  UploadMessageView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI

struct UploadMessageView: View {
    @ObservedObject var viewModel: MessagesViewModel
    @State var title = ""
    @State var message = ""
    @State var selectedImage: UIImage?
    @State var messageImage: Image?
    @State var imagePickerPresented = false
    @Binding var showUploadMessageView: Bool
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    Text("ถึง")
                }
                
                Button {
                    
                } label: {
                    Text("เลือกสมาชิก")
                        .padding()
                        .border(.gray)
                }
                
                HStack {
                    Text("เรื่อง")
                }
                
                ZStack(alignment: .topLeading) {
                           if title.isEmpty {
                               Text("")
                                   .foregroundColor(Color(UIColor.placeholderText))
                                   .padding(.horizontal, 8)
                                   .padding(.vertical, 16)
                           }
                           
                           TextEditor(text: $title)
                               .border(.gray)
                               .padding(4)
                       }
                       .font(.body)
                    
                HStack {
                    Text("เขียนข้อความ")
                }
                
                ZStack(alignment: .topLeading) {
                           if message.isEmpty {
                               Text("")
                                   .foregroundColor(Color(UIColor.placeholderText))
                                   .padding(.horizontal, 8)
                                   .padding(.vertical, 16)
                           }
                           
                           TextEditor(text: $message)
                               .border(.gray)
                               .padding(4)
                       }
                       .font(.body)
                
          
                
                if messageImage == nil {
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
                        } else if let image = messageImage {
                            VStack {
                                HStack(alignment: .top) {
                                    image.resizeTo(width: 96, height: 96)
                                        .clipped()
                                }
                                .padding()
                            }
                        }
              
                
                Button {
                    if let image = selectedImage {
                        viewModel.sendMessage(image: image, title: title, message: message)
                    } else {
                        viewModel.sendMessage(image: nil, title: title, message: message)
                    }
                    showUploadMessageView.toggle()
                    title = ""
                    message = ""
                    messageImage = nil
                } label: {
                    Text("ส่งข้อความ")
                        .foregroundColor(.white)
                        .frame(width: 360, height: 35)
                        .background(.green)
                        .cornerRadius(5)
                }
            }
        }
        .padding()
    }
    
    func loadImage() {
            guard let selectedImage = selectedImage else { return }
            messageImage = Image(uiImage: selectedImage)
        }
}
