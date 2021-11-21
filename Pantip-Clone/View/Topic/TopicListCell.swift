//
//  TopicListCell.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI

struct TopicListCell: View {
    let topic: Topic
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color(UIColor(named: "tabbar")!))
                .opacity(0.5)
            VStack(alignment: .leading) {
                HStack {
                    Text(topic.title)
                        .font(.title).bold()
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .padding(.trailing, 6)
                }
                Text(topic.caption)
                    .bold()
            }
            .padding(8)
            .overlay(RoundedRectangle(cornerRadius: 3).stroke())
            .padding(.top, 4)
        }
    }
}


