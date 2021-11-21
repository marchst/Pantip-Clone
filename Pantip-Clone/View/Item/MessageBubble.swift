//
//  MessageBubble.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI

struct MessageBubble: Shape {
    var ownAccount: Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, ownAccount ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 15, height: 15))
        return Path(path.cgPath)
    }
}
