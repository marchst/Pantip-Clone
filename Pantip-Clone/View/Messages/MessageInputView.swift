//
//  MessageInputView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct MessageInputView: View {
    @ObservedObject var viewModel: MessagesViewModel
    @Binding var showMessageInputView: Bool
    @State var selectedImage: UIImage?
    @State var messageImage: Image?
    @State var imagePickerPresented = false
    @State var message = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
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
                .padding()
                .background(Color(UIColor(named: "background")!))
                
                HStack {
                    if messageImage == nil {
                        Spacer()
                            Button(action: {
                                imagePickerPresented.toggle()
                            }) {
                                Image(systemName: "plus.circle")
                                    .resizeTo(width: 30, height: 30)
                                    .padding(.top)
                                    .foregroundColor(.gray)
                            }
                            .sheet(isPresented: $imagePickerPresented) {
                                loadImage()
                            } content: {
                                ImagePicker(image: $selectedImage)
                            }
                            .padding()
                        Spacer()
                        } else if let image = messageImage {
                            VStack(spacing: 0) {
                                HStack(alignment: .top) {
                                    Spacer()
                                    image.resizeTo(width: 96, height: 96)
                                        .clipped()
                                    Spacer()
                                }
                                .padding()
                            }
                            .background(Color(UIColor(named: "background")!))
                        }
                }
                .background(Color(UIColor(named: "background")!))
                
                
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
                            viewModel.sendMessage(image: image, title: "", message: message)
                        } else {
                            viewModel.sendMessage(image: nil, title: "", message: message)
                        }
                        showMessageInputView.toggle()
                        message = ""
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
                    .background(Color(UIColor(named: "tabbar")!))
                }
                .padding(.horizontal)
                .background(Color(UIColor(named: "tabbar")!))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("ส่งข้อความ")
                .foregroundColor(.gray)
            }
        }
    }
    
    func loadImage() {
            guard let selectedImage = selectedImage else { return }
            messageImage = Image(uiImage: selectedImage)
        }
}
