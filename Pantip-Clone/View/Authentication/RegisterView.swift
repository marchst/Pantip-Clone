//
//  RegisterView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 16/11/2564 BE.
//

import SwiftUI

struct RegisterView: View {
    @State var email = ""
    @State var username = ""
    @State var fullname = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
//        NavigationView {
            ZStack {
                Color(UIColor(named: "background")!).edgesIgnoringSafeArea(.bottom)
                VStack {
                    Image("pantip-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .padding(36)
                    
                    VStack(spacing: -16) {
                        CustomTextField(placeholder: Text("Email"), text: $email, imageName: "envelope")
                            .padding()
                            .padding(.horizontal, 32)
                        
                        CustomTextField(placeholder: Text("Username"), text: $username, imageName: "person")
                            .padding()
                            .padding(.horizontal, 32)
                        
                        CustomTextField(placeholder: Text("Fullname"), text: $fullname, imageName: "person")
                            .padding()
                            .padding(.horizontal, 32)
                        
                        CustomSecureField(placeholder: Text("Password"), text: $password)
                            .padding()
                            .padding(.horizontal, 32)
                    }
                    
                    Button {
                        viewModel.register(withEmail: email, password: password, username: username, fullname: fullname)
                    } label: {
                        Text("ลงทะเบียน")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(Color(UIColor(named: "button")!))
                            .cornerRadius(5)
                            .padding()
                    }
                    
                    
//                    NavigationLink(
//                        destination: SigninView().navigationBarHidden(true),
//                        label: {
//                            HStack {
//                                Text("Already have an account?")
//                                    .font(.system(size: 14, weight: .semibold))
//
//                                Text("Sign in")
//                                    .font(.system(size: 14))
//                            }
//                        }
//                    )
                }
            }
            .navigationTitle("ลงทะเบียน")
            .navigationBarColor(UIColor(named: "tabbar")!)
            .navigationBarTitleDisplayMode(.inline)
//        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
//            .environmentObject(AuthViewModel.shared)
    }
}
