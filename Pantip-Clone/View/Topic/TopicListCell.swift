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
        VStack(alignment: .leading) {
            HStack {
                Text(topic.title)
                    .font(.title)
                Spacer()
                Image(systemName: "chevron.forward")
            }
            Text(topic.caption)
        }
        .padding(4)
        .overlay(RoundedRectangle(cornerRadius: 3).stroke())
        .padding(.top, 4)
    }
}


