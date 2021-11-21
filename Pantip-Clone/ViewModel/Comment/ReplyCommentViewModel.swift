//
//  ReplyCommentViewModel.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI
import Firebase

class ReplyCommentViewModel: ObservableObject {
    let topic: Topic
    let comment: Comment
    
    @Published var replyComments = [ReplyComment]()
    init(topic: Topic, comment: Comment) {
        self.topic = topic
        self.comment = comment
        fetchReplyComments()
    }
    func uploadReplyComment(image: UIImage?, replyComment: String) {
        guard let topicID = topic.id else { return }
        guard let commentID = comment.id else { return }
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let userID = user.id else { return }
        
        if image == nil {
            let data: [String: Any] = [
                "replyComment": replyComment,
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
                "commentOwnerID": self.comment.uid,
                "username": user.username,
                "profileImageURL": user.profileImageURL as Any
            ]
            
            Firestore.firestore().collection("topics").document(topicID).collection("topic-comments").document(commentID).collection("comment-replys").addDocument(data: data) { error in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        
                NotificationsViewModel.sendNotification(withUID: self.comment.uid, type: .reply, topic: self.topic, comment: self.comment)
                    }
        } else {
        
            ImageUploader.uploadImage(image: image!, type: .replycomment) { imageURL in
                
                let data: [String: Any] = [
                    "replyComment": replyComment,
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
                    "commentOwnerID": self.comment.uid,
                    "username": user.username,
                    "profileImageURL": user.profileImageURL as Any
                ]
                
                Firestore.firestore().collection("topics").document(topicID).collection("topic-comments").document(commentID).collection("comment-replys").addDocument(data: data) { error in
                            if let error = error {
                                print(error.localizedDescription)
                                return
                            }
                            
    //                        NotificationsViewModel.sendNotification(withUID: self.post.ownerUID, type: .comment, post: self.post)
                        }
            }
        }
    }
    
    func fetchReplyComments() {
           guard let topicID = topic.id else { return }
           guard let commentID = comment.id else { return }
           
           Firestore.firestore().collection("topics").document(topicID).collection("topic-comments").document(commentID).collection("comment-replys").order(by: "timestamp",descending: true).addSnapshotListener { (snap, error) in
               if let error = error {
                   print(error.localizedDescription)
                   return
               }
               
               guard let documentChanges = snap?.documentChanges.filter({ $0.type == .added }) else { return }
               self.replyComments.append(contentsOf: documentChanges.compactMap{ try? $0.document.data(as: ReplyComment.self)})
           }
       }
}
