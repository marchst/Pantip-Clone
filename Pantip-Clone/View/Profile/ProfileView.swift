//
//  ProfileView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 19/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: ProfileViewModel
    @State var selectedImage: UIImage?
    @State var imagePickerPresented = false
    @State var tabIndex = 0
    var body: some View {
        //        NavigationView{
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
                
                
                Text("ข้อมูลส่วนตัว")
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
                        .opacity(0)
                }
                .disabled(true)
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
                        .opacity(0)
                }
                .disabled(true)
                .padding(8)
                .padding(.bottom, 8)
                
            }
            .background(Color(UIColor(named: "tabbar")!))
            
            
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            imagePickerPresented.toggle()
                        } label: {
                            if let imageURL = viewModel.user.profileImageURL {
                                KFImage(URL(string: imageURL))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .padding(.top)
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizeTo(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .padding(.top)
                            }
                        }
                        .disabled(viewModel.user.isCurrentUser ? false : true)
                        .sheet(isPresented: $imagePickerPresented) {
                            loadImage()
                        } content: {
                            ImagePicker(image: $selectedImage)
                            
                        }
//                        Image("pran")
//                            .resizable()
//                            .clipShape(Circle())
//                            .frame(width: 80, height: 80)
//                            .clipped()
//                            .padding(.top)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Text(viewModel.user.username)
                            .foregroundColor(.gray)
                            .font(.system(size: 24, weight: .semibold))
                        Spacer()
                    }
                    .padding()
                    
                    ProfileButtonView(viewModel: viewModel)
                    
                    if viewModel.user.isCurrentUser {
                        VStack{
                            CustomTopTabBar(tabIndex: $tabIndex)
                            if tabIndex == 0 {
                                OwnTopicListView()
                            }
    //                        else {
    //                            AnswerTopicListView()
    //                        }
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width - 24, alignment: .center)
                        .padding(.horizontal, 12)
                    }
                }
            }
            .padding(.top, 4)
            .background(Color(UIColor(named: "background")!))
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
    
    func loadImage() {
            guard let selectedImage = selectedImage else { return }
            viewModel.changeProfileImage(image: selectedImage)
    }
}

