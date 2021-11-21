//
//  NavigationBarHidden.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 19/11/2564 BE.
//

import SwiftUI

struct HiddenNavigationBar: ViewModifier {
    @State var isHidden: Bool = true

       func body(content: Content) -> some View {
           content
               .navigationBarTitle("")
               .navigationBarHidden(isHidden)
               .onAppear { self.isHidden = true }
       }
}
