//
//  UploadTopicView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI

struct UploadTopicView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var tags = ["","","","",""]
    @ObservedObject var viewModel = UploadTopicViewModel()
    @State var type: String
    @State var title = ""
    @State var caption = ""
    @State var selectedImage: UIImage?
    @State var topicImage: Image?
    @State var imagePickerPresented = false
    @State var typeTitle: String
    @Binding var showUploadTopicView: Bool
    @State var showSelectTagView = false
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
                    
            }
       
            
            
            Spacer()
            
            
            Text(typeTitle)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color(UIColor(named: "selected-icon")!))
                .padding(.bottom, 8)
            
            Spacer()
            
            
            Button {
                showUploadTopicView.toggle()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color(UIColor(named: "selected-icon")!))
                    .clipped()
            }
            .padding(.trailing, 8)
            .padding(8)
            
        }
        .background(Color(UIColor(named: "tabbar")!))
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("1. ระบุหัวข้อกระทู้ของคุณ")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray)
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
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray)
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
                
                HStack {
                    Spacer()
                    if topicImage == nil {
                        Button(action: {
                            imagePickerPresented.toggle()
                        }) {
                            Image(systemName: "plus.circle")
                                .resizeTo(width: 30, height: 30)
                                .padding([.top, .bottom])
                                .foregroundColor(Color(UIColor(named: "selected-icon")!))
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
                    Spacer()
                }
                
                HStack {
                    Text("3. เลือกแท็กที่เกี่ยวข้องกับกระทู้")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Spacer()
                    Button {
                        showSelectTagView.toggle()
                    } label: {
                        if tags[0].isEmpty {
                            Text("เพิ่มแท็ก")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(UIColor(named: "selected-icon")!))
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
                    Spacer()
                }
                .padding()
                
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
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 360, height: 35)
                        .background(.green)
                        .cornerRadius(5)
                }
//            }.background(Color(UIColor(named: "background")!))
        }
            
        .padding()
        }
        .background(Color(UIColor(named: "background")!))
    }
    }
    
    func loadImage() {
            guard let selectedImage = selectedImage else { return }
            topicImage = Image(uiImage: selectedImage)
        }
}

//struct UploadTopicView_Previews: PreviewProvider {
//    static var previews: some View {
//        UploadTopicView(type: "news", showUploadTopicView: .constant(true))
//    }
//}
