//
//  SigninView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 16/11/2564 BE.
//

import SwiftUI

struct SigninView: View {
    @EnvironmentObject var  viewModel: AuthViewModel
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(named: "background")!).edgesIgnoringSafeArea(.bottom)
                VStack {
                    Image("pantip-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .padding(.bottom, 42)
                    VStack(spacing: -16) {
                        CustomTextField(placeholder: Text("Email"), text: $email, imageName: "envelope")
                            .padding()
                            .padding(.horizontal, 32)
                        
                        CustomSecureField(placeholder: Text("Password"), text: $password)
                            .padding()
                            .padding(.horizontal, 32)
                        
                        
                    }
                    HStack {
                        Spacer()
                        Text("ฉันลืมรหัสผ่าน ?")
                            .foregroundColor(Color(UIColor(named: "forgotpass")!))
                            .padding(.horizontal, 36)
                            .padding()
                    }
                    
                    Button {
                        viewModel.signIn(withEmail: email, password: password)
                    } label: {
                        Text("เข้าสู่ระบบ")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(Color(UIColor(named: "button")!))
                            .cornerRadius(5)
                    }
                    
                    Text("หรือ")
                        .foregroundColor(.gray)
                        .padding(.vertical, 6)
                    
                    NavigationLink(
                        destination: RegisterView().navigationBarTitleDisplayMode(.inline),
                        label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 5)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 360, height: 50)
                                Text("ลงทะเบียน")
                                    .foregroundColor(.black)
                            }
                        }
                    )
                }
                
            }
            .navigationBarColor(UIColor(named: "tabbar")!)
            .navigationBarTitle("เข้าสู่ระบบ")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
            .environmentObject(AuthViewModel.shared)
    }
}
