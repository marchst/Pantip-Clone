//
//  CommentCellViewModel.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI
import Firebase

class CommentCellViewModel: ObservableObject {
    @Published var comment: Comment
    let topic: Topic
    
    init(comment: Comment, topic: Topic) {
        self.comment = comment
        self.topic = topic
        fetchUser()
        checkVote()
        checkLike()
    }
    
    func fetchUser() {
        Firestore.firestore().collection("users").document(comment.uid).getDocument { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.comment.user = try? snap?.data(as: User.self)
            
            guard let userImageURL = self.comment.user?.profileImageURL else { return }
            self.comment.profileImageURL = userImageURL
        }
    }
    
    func vote() {
        if let didVote = comment.didVote, didVote {
            return
        }
        
        guard let topicID = topic.id else { return }
        guard let commentID = comment.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }

        Firestore.firestore().collection("topics").document(topicID).collection("topic-comments").document(commentID).collection("comment-votes").document(userID).setData([:]) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            Firestore.firestore().collection("users").document(userID).collection("user-votes").document(commentID).setData([:]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                Firestore.firestore().collection("topics").document(topicID).collection("topic-comments").document(commentID).updateData([ "votes": self.comment.votes + 1 ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }

//                NotificationsViewModel.sendNotification(withUID: self.post.ownerUID, type: .like, post: self.post)
                self.comment.votes += 1
                self.comment.didVote = true
            }
        }
    }
    
    func checkVote() {
        guard let topicID = topic.id else { return }
        guard let commentID = comment.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }

        Firestore.firestore().collection("topics").document(topicID).collection("topic-comments").document(commentID).collection("comment-votes").document(userID).getDocument { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let didVote = snap?.exists else { return }
            self.comment.didVote = didVote
        }
    }
    
    func unvote() {
        if let didVote = comment.didVote, !didVote {
            return
        }
        
        guard let topicID = topic.id else { return }
        guard let commentID = comment.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }

        Firestore.firestore().collection("topics").document(topicID).collection("topic-comments").document(commentID).collection("comment-votes").document(userID).delete() { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            Firestore.firestore().collection("users").document(userID).collection("user-votes").document(commentID).delete(){ error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                Firestore.firestore().collection("topics").document(topicID).collection("topic-comments").document(commentID).updateData([ "votes": self.comment.votes - 1 ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }

                self.comment.votes -= 1
                self.comment.didVote = false
            }
        }
    }
    
    func like() {
        if let didLike = comment.didLike, didLike {
            return
        }
        guard let topicID = topic.id else { return }
        guard let commentID = comment.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }

        Firestore.firestore().collection("topics").document(topicID).collection("topic-comments").document(commentID).collection("comment-likes").document(userID).setData([:]) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            Firestore.firestore().collection("users").document(userID).collection("user-likes").document(commentID).setData([:]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                Firestore.firestore().collection("topics").document(topicID).collection("topic-comments").document(commentID).updateData([ "likes": self.comment.likes + 1 ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }

//                NotificationsViewModel.sendNotification(withUID: self.post.ownerUID, type: .like, post: self.post)
                self.comment.likes += 1
                self.comment.didLike = true
            }
        }
    }
    
    func checkLike() {
        guard let topicID = topic.id else { return }
        guard let commentID = comment.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }

        Firestore.firestore().collection("topics").document(topicID).collection("topic-comments").document(commentID).collection("comment-likes").document(userID).getDocument { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let didLike = snap?.exists else { return }
            self.comment.didLike = didLike
        }
    }
    
    func unlike() {
        if let didLike = comment.didLike, !didLike {
            return
        }
        guard let topicID = topic.id else { return }
        guard let commentID = comment.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }

        Firestore.firestore().collection("topics").document(topicID).collection("topic-comments").document(commentID).collection("comment-likes").document(userID).delete() { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            Firestore.firestore().collection("users").document(userID).collection("user-likes").document(commentID).delete(){ error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                Firestore.firestore().collection("topics").document(topicID).collection("topic-comments").document(commentID).updateData([ "likes": self.comment.likes - 1 ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }

                self.comment.likes -= 1
                self.comment.didLike = false
            }
        }
    }
    
    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 3
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: comment.timestamp.dateValue(), to:  Date()) ?? ""
    }
    
//    var likeText: String {
//        let label = post.likes == 1 ? "like" : "likes"
//        return "\(post.likes) \(label)"
//    }
}
