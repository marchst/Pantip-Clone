//
//  NotificationsViewModel.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI
import Firebase

class NotificationsViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    
    init() {
        fetchNotifications()
    }
    
    func fetchNotifications() {
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("notifications").document(userID).collection("user-notifications").order(by: "timestamp", descending: true).getDocuments { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            self.notifications = documents.compactMap{ try? $0.data(as: Notification.self) }
        }
    }
    
    static func sendNotification(withUID uid: String, type: NotificationType, topic: Topic? = nil, comment: Comment? = nil) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let userID = user.id else { return }
        
        var data: [String: Any] = [
            "timestamp": Timestamp(date: Date()),
            "username": user.username,
            "uid": userID,
            "profileImageURL": user.profileImageURL as Any,
            "type": type.rawValue
        ]
        
        if let topic = topic, let id = topic.id {
            data["topicID"] = id
        }
        
        if let comment = comment, let id = comment.id {
            data["commentID"] = id
        }
        
        Firestore.firestore().collection("notifications").document(uid).collection("user-notifications").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
}
