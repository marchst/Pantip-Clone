//
//  CommentsViewModel.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI
import Firebase

class CommentViewModel: ObservableObject {
    let topic: Topic
    
    @Published var comments = [Comment]()
    init(topic: Topic) {
        self.topic = topic
        fetchComments()
    }
    func uploadComment(image: UIImage?, comment: String) {
        guard let topicID = topic.id else { return }
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let userID = user.id else { return }
        
        if image == nil {
            let data: [String: Any] = [
                "comment": comment,
                "uid": userID,
                "timestamp": Timestamp(date: Date()),
                "likes": 0,
                "funnys": 0,
                "loves": 0,
                "sads": 0,
                "scares": 0,
                "wows": 0,
                "votes": 0,
                "imageURL": "",
                "topicOwnerID": self.topic.ownerUID,
                "username": user.username,
                "profileImageURL": user.profileImageURL as Any
            ]
            
            Firestore.firestore().collection("topics").document(topicID).collection("topic-comments").addDocument(data: data) { error in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        
                        NotificationsViewModel.sendNotification(withUID: self.topic.ownerUID, type: .comment, topic: self.topic)
                    }
        } else {
        
            ImageUploader.uploadImage(image: image!, type: .comment) { imageURL in
                
                let data: [String: Any] = [
                    "comment": comment,
                    "uid": userID,
                    "timestamp": Timestamp(date: Date()),
                    "likes": 0,
                    "funnys": 0,
                    "loves": 0,
                    "sads": 0,
                    "scares": 0,
                    "wows": 0,
                    "votes": 0,
                    "imageURL": imageURL as Any,
                    "topicOwnerID": self.topic.ownerUID,
                    "username": user.username,
                    "profileImageURL": user.profileImageURL as Any
                ]
                
                Firestore.firestore().collection("topics").document(topicID).collection("topic-comments").addDocument(data: data) { error in
                            if let error = error {
                                print(error.localizedDescription)
                                return
                            }
                            
                            NotificationsViewModel.sendNotification(withUID: self.topic.ownerUID, type: .comment, topic: self.topic)
                        }
            }
        }
    }
    
    func fetchComments() {
           guard let topicID = topic.id else { return }
           
           Firestore.firestore().collection("topics").document(topicID).collection("topic-comments").order(by: "timestamp",descending: false).addSnapshotListener { (snap, error) in
               if let error = error {
                   print(error.localizedDescription)
                   return
               }
               
               guard let documentChanges = snap?.documentChanges.filter({ $0.type == .added }) else { return }
               self.comments.append(contentsOf: documentChanges.compactMap{ try? $0.document.data(as: Comment.self)})
           }
       }
    
}
