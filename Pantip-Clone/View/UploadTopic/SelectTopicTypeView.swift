//
//  SelectTopicTypeView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI

struct SelectTopicTypeView: View {
    @Binding var showUploadTopicView: Bool
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Button {
                    } label: {
                        Image(systemName: "chevron.backward")
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray)
                            .padding(8)
                            .padding(.bottom, 8)
                            .opacity(0)
                    }
                    .disabled(true)
                    
                    
                    Spacer()
                    
                    
                    Text("ตั้งกระทู้")
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
                    Text("เลือกประเภทกระทู้")
                        .foregroundColor(.gray)
                        .font(.caption2)
                    
                    NavigationLink(destination: UploadTopicView(type: "question", typeTitle: "กระทู้คำถาม", showUploadTopicView: $showUploadTopicView).navigationBarHidden(true)) {
                        HStack {
                            Image("question")
                                .resizeTo(width: 38, height: 38)
                            Text("กระทู้คำถาม")
                                .foregroundColor(.gray)
                                .padding()
                            
                            Spacer()
                            
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    NavigationLink(destination: UploadTopicView(type: "conversation", typeTitle: "กระทู้สนทนา", showUploadTopicView: $showUploadTopicView).navigationBarHidden(true)) {
                        HStack {
                            Image("conversation")
                                .resizeTo(width: 26, height: 26)
                                .padding(.leading, 6)
                            Text("กระทู้สนทนา")
                                .foregroundColor(.gray)
                                .padding()
                                .padding(.leading, 6)

                            
                            Spacer()
                            
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    NavigationLink(destination: UploadTopicView(type: "news", typeTitle: "กระทู้ข่าว", showUploadTopicView: $showUploadTopicView).navigationBarHidden(true)) {
                        HStack {
                            Image("news")
                                .resizeTo(width: 38, height: 38)
                            Text("กระทู้ข่าว")
                                .foregroundColor(.gray)
                                .padding()
                            
                            Spacer()
                            
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.gray)
                            
                        }
                    }
                }
                .padding()
            }
            .background(Color(UIColor(named: "background")!))
            .navigationTitle("")
            .navigationBarHidden(true)
            }
        }
    }
}

struct SelectTopicTypeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTopicTypeView(showUploadTopicView: .constant(true))
    }
}
