//
//  Notification.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Notification: Decodable, Identifiable {
    @DocumentID var id: String?
    var topicID: String?
    var username: String
    var profileImageURL: String?
    var timestamp: Timestamp
    var uid: String
    var type: NotificationType
    
    var topic: Topic?
    var user: User?
    
}

enum NotificationType: Int, Decodable {
    case reply
    case comment
    
    var notificationMessage: String {
        switch self {
        case .reply:
            return " ได้ตอบกลับความคิดเห็นของคุณ."
        case .comment:
            return " ได้แสดงความคิดเห็นในกระทู้ของคุณ."
        }
        
    }
}
