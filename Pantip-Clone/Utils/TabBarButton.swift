//
//  TabBarButton.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 19/11/2564 BE.
//

import SwiftUI

struct TabBarButton: View {
    let text: String
    @Binding var isSelected: Bool
    
    var body: some View {
        Text(text)
            .fontWeight(isSelected ? .heavy : .regular)
            .foregroundColor(isSelected ? .yellow : .gray)
            .font(.custom("Avenir", size: 16))
            .padding(.bottom,10)
            .border(width: isSelected ? 2 : 1, edges: [.bottom], color: .black)
    }
}
