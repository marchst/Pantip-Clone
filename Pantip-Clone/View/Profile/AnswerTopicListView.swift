//
//  AnswerTopicListView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 19/11/2564 BE.
//

import SwiftUI

struct AnswerTopicListView: View {
    var body: some View {
        
        ScrollView {
            ForEach(0..<10) { _ in
                
                VStack(alignment: .leading) {
                    Text("ทดสอบ2")
                    
                    HStack {
                        Text("ปราณคนเนี้ยบ")
                            .font(.caption2)
                        Text("14 พ.ย.")
                            .font(.caption2)
                        Spacer()
                        Image("comments")
                            .resizable()
                            .frame(width: 14, height: 14)
                        Text("1")
                            .font(.caption2)
                    }
                }
                .padding()
            }
        }
        .background(Color.white)
    }
}

struct AnswerTopicListView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerTopicListView()
    }
}
