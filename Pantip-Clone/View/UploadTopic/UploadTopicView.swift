//
//  UploadTopicView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI

struct UploadTopicView: View {
    @State var tags = ["","","","",""]
    @ObservedObject var viewModel = UploadTopicViewModel()
    @State var type: String
    @State var title = ""
    @State var caption = ""
    @State var selectedImage: UIImage?
    @State var topicImage: Image?
    @State var imagePickerPresented = false
    @Binding var showUploadTopicView: Bool
    @State var showSelectTagView = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("1. ระบุหัวข้อกระทู้ของคุณ")
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
                    Text("2. เขียนรายละเอียดกระทู้")
                }
                
                ZStack(alignment: .topLeading) {
                           if caption.isEmpty {
                               Text("")
                                   .foregroundColor(Color(UIColor.placeholderText))
                                   .padding(.horizontal, 8)
                                   .padding(.vertical, 16)
                           }
                           
                           TextEditor(text: $caption)
                               .border(.gray)
                               .padding(4)
                       }
                       .font(.body)
                
                if topicImage == nil {
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
                        } else if let image = topicImage {
                            VStack {
                                HStack(alignment: .top) {
                                    image.resizeTo(width: 96, height: 96)
                                        .clipped()
                                }
                                .padding()
                            }
                        }
                
                HStack {
                    Text("3. เลือกแท็กที่เกี่ยวข้องกับกระทู้")
                }
                
                HStack {
                    Button {
                        showSelectTagView.toggle()
                    } label: {
                        if tags[0].isEmpty {
                            Text("เพิ่มแท็ก")
                                .padding()
                                .border(.gray)
                        } else {
                            Text(tags[0])
                                .padding()
                                .border(.gray)
                        }
                    }
                    .sheet(isPresented: $showSelectTagView) {
                        SelectTagView(tags: $tags)
                    }
                }
                
                Button {
                    if let image = selectedImage {
                        viewModel.uploadTopic(image: image, type: type, title: title, caption: caption, tags: tags)
                    } else {
                        viewModel.uploadTopic(image: nil, type: type, title: title, caption: caption, tags: tags)
                    }
                    showUploadTopicView.toggle()
                    title = ""
                    caption = ""
                    topicImage = nil
                } label: {
                    Text("ส่งกระทู้")
                        .foregroundColor(.white)
                        .frame(width: 360, height: 35)
                        .background(.green)
                        .cornerRadius(5)
                }
//            }.background(Color(UIColor(named: "background")!))
        }
//        .background(Color(UIColor(named: "background")!))
        .padding()
    }
    }
    
    func loadImage() {
            guard let selectedImage = selectedImage else { return }
            topicImage = Image(uiImage: selectedImage)
        }
}

struct UploadTopicView_Previews: PreviewProvider {
    static var previews: some View {
        UploadTopicView(type: "news", showUploadTopicView: .constant(true))
    }
}
