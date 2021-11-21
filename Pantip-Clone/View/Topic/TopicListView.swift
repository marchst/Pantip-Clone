//
//  TopicListView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI

struct TopicListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: SearchViewModel
    @Binding var searchText: String
    @State var searchType: String
    var topics: [Topic] {
        searchType == "tag" ? viewModel.filterTags(withText: searchText): viewModel.filterTopics(withText: searchText)
    }
    var body: some View {
        if searchType != "tag" {
            ScrollView {
                if searchText.isEmpty {
                    HStack {
                        Spacer()
                        Text("พิมพ์เพื่อค้นหากระทู้")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                    }
                } else {
                    VStack(alignment: .leading){
                        HStack{
                            Spacer()
                            Text("ค้นหากระทู้ที่มีคำว่า \(searchText)")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        ForEach(topics) { topic in
                            NavigationLink(destination: TopicView(viewModel: FeedCellViewModel(topic: topic)).navigationBarTitleDisplayMode(.inline)) {
                                TopicListCell(topic: topic)
                            }
                            
                        }
                    }
                    .padding()
                }
            }
        } else {
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
                    
                    Text("แท็ก")
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
                    }
                    .padding(.trailing ,8)
                    .padding(.bottom, 8)
                    
                    Button {
                        
                    } label: {
                        Image("new_topic")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray)
                            .clipped()
                    }
                    .padding(8)
                    .padding(.bottom, 8)
                    
                }
                .background(Color(UIColor(named: "tabbar")!))
                
                
                ScrollView {
                    
                    VStack(alignment: .leading){
                        HStack{
                            Spacer()
                            Text("ค้นหากระทู้ที่มีแท็ก \(searchText)")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        ForEach(topics) { topic in
                            NavigationLink(destination: TopicView(viewModel: FeedCellViewModel(topic: topic)).navigationBarTitleDisplayMode(.inline)) {
                                TopicListCell(topic: topic)
                            }
                            
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
}


