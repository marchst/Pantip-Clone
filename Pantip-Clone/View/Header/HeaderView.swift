//
//  HeaderView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 11/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct HeaderView: View {
    @State var user: User
    @ObservedObject var viewModel: ProfileViewModel
    @Binding var selectedIndex: Int
    //    @Binding var text: String
    @Binding var searchText: String
    @Binding var inSearchMode: Bool
    @State var showUploadTopicView = false
    //    @Binding var isEditting: Bool
    var body: some View {
        HStack {
            
            if selectedIndex != 5 {
            NavigationLink(
                destination: ProfileView(viewModel: viewModel).navigationBarTitleDisplayMode(.inline),
                label: {
                    if let imageURL = viewModel.user.profileImageURL {
                        KFImage(URL(string: imageURL))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                            .padding(8)
                            .padding(.bottom, 8)
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizeTo(width: 24, height: 24)
                            .clipShape(Circle())
                            .padding(8)
                            .padding(.bottom, 8)
                    }
                })
            }
            
            if selectedIndex == 5 {
                Button {
                    
                } label: {
                    Image(systemName: "chevron.backward")
                        .frame(width: 24, height: 24)
                        .padding(8)
                        .padding(.bottom, 8)
                }
            }
            
            if selectedIndex == 4 || selectedIndex == 5 {
                Circle()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 8)
                    .opacity(0)
            }
            
            Spacer()
            
            if selectedIndex == 0 || selectedIndex == 1 {
                TextField("", text: $searchText)
                    .padding(6)
                    .padding(.horizontal, 26)
                    .font(.system(size: 14, weight: .semibold))
                    .placeholder(when: searchText.isEmpty) {
                            Text("ค้นหา").foregroundColor(.gray)
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.leading, 36)
                    }
                    .foregroundColor(Color(UIColor(named: "selected-icon")!))
                    .background(Color(UIColor(named: "searchbox")!))
                    .cornerRadius(6)
                    .overlay(
                        HStack {
                            Image("search")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(.gray)
                                    .frame(width: 16, height: 12, alignment: .trailing)
                                    .opacity(searchText.isEmpty ? 0 : 0.65)
                                    
                            }
                            .disabled(searchText.isEmpty ? true : false)
                            
                        }
                            .padding(.leading, 8)
                            .padding(.trailing, 4)
                        
                        
                    )
                    .padding(.bottom, 8)
                    .onTapGesture {
                        inSearchMode = true
                    }
            } else {
                Text(tabTitle)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(UIColor(named: "selected-icon")!))
                    .padding(.bottom, 8)
            }
            
            Spacer()
            
            
            if selectedIndex == 4 || selectedIndex == 5{
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
            }
            
            
            if inSearchMode {
                Button {
                    inSearchMode = false
                    searchText = ""
                    UIApplication.shared.endEditting()
                } label: {
                    Text("ยกเลิก")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.bottom, 8)
                }
            } else {
                Button {
                    showUploadTopicView.toggle()
                } label: {
                    Image("new_topic")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                        .clipped()
                        .opacity(selectedIndex == 2 ? 0 : 1)
                }
                .disabled(selectedIndex == 2 ? true : false)
                .padding(8)
                .padding(.bottom, 8)
                .sheet(isPresented: $showUploadTopicView) {
                    SelectTopicTypeView(showUploadTopicView: $showUploadTopicView)
                }
            }
            

            
        }
        .padding(.horizontal, 4)
        .background(Color(UIColor(named: "tabbar")!))
    }
    
    
    var tabTitle: String {
        switch selectedIndex {
        case 0: return "หน้าแรก"
        case 1: return "แท็ก"
        case 2: return "แจ้งเตือน"
        case 3: return "ข้อความ"
        case 4: return "อื่นๆ"
        case 5: return "ข้อมูลส่วนตัว"
        default: return ""
        }
    }
}


