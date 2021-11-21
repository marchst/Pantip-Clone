//
//  NotificationsCellViewModel.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI
import Firebase

class NotificationsCellViewModel: ObservableObject {
    @Published var notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
        fetchUser()
        fetchPost()
    }
    
    func fetchUser() {
        Firestore.firestore().collection("users").document(notification.uid).getDocument { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.notification.user = try? snap?.data(as: User.self)
        }
    }
    
    func fetchPost() {
        guard let topicID = notification.topicID else { return }
        
        Firestore.firestore().collection("topics").document(topicID).getDocument { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.notification.topic = try? snap?.data(as: Topic.self)
        }
    }
   
    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to:  Date()) ?? ""
    }
}
