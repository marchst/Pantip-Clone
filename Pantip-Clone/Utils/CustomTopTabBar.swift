//
//  CustomTopTabBar.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 19/11/2564 BE.
//

import SwiftUI

struct CustomTopTabBar: View {
    @Binding var tabIndex: Int
    var body: some View {
        HStack(spacing: 20) {
            TabBarButton(text: "กระทู้ที่ตั้ง", isSelected: .constant(tabIndex == 0))
                .onTapGesture { onButtonTapped(index: 0) }
            TabBarButton(text: "กระทู้ที่ตอบ", isSelected: .constant(tabIndex == 1))
                .onTapGesture { onButtonTapped(index: 1) }
            Spacer()
        }
        .background(Color(UIColor(named: "tabbar")!))
        .border(width: 2, edges: [.bottom], color: .gray)
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}
