//
//  ReplyCellViewModel.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI
import Firebase

class ReplyCellViewModel: ObservableObject {
    @Published var replyComment: ReplyComment
    
    init(replyComment: ReplyComment) {
        self.replyComment = replyComment
        fetchUser()
        checkVote()
    }
    
    func fetchUser() {
        Firestore.firestore().collection("users").document(replyComment.uid).getDocument { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.replyComment.user = try? snap?.data(as: User.self)
            
            guard let userImageURL = self.replyComment.user?.profileImageURL else { return }
            self.replyComment.profileImageURL = userImageURL
        }
    }
    
    func vote() {
        if let didVote = replyComment.didVote, didVote {
            return
        }
        guard let replyCommentID = replyComment.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("replyComments").document(replyCommentID).collection("replyComment-votes").document(userID).setData([:]) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("users").document(userID).collection("user-votes").document(replyCommentID).setData([:]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                Firestore.firestore().collection("replyComments").document(replyCommentID).updateData([ "votes": self.replyComment.votes + 1 ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }
                
                //                NotificationsViewModel.sendNotification(withUID: self.post.ownerUID, type: .like, post: self.post)
                self.replyComment.votes += 1
                self.replyComment.didVote = true
            }
        }
    }
    
    func checkVote() {
        guard let replyCommentID = replyComment.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("replyComments").document(replyCommentID).collection("replyComment-votes").document(userID).getDocument { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let didVote = snap?.exists else { return }
            self.replyComment.didVote = didVote
        }
    }
    
    func unvote() {
        if let didVote = replyComment.didVote, !didVote {
            return
        }
        guard let replyCommentID = replyComment.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("replyComments").document(replyCommentID).collection("replyComment-votes").document(userID).delete() { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("users").document(userID).collection("user-votes").document(replyCommentID).delete(){ error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                Firestore.firestore().collection("replyComments").document(replyCommentID).updateData([ "votes": self.replyComment.votes - 1 ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }
                
                self.replyComment.votes -= 1
                self.replyComment.didVote = false
            }
        }
    }
    
    func like() {
        if let didLike = replyComment.didLike, didLike {
            return
        }
        guard let replyCommentID = replyComment.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }

        Firestore.firestore().collection("replyComments").document(replyCommentID).collection("replyComment-likes").document(userID).setData([:]) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            Firestore.firestore().collection("users").document(userID).collection("user-likes").document(replyCommentID).setData([:]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                Firestore.firestore().collection("replyComments").document(replyCommentID).updateData([ "likes": self.replyComment.likes + 1 ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }

//                NotificationsViewModel.sendNotification(withUID: self.post.ownerUID, type: .like, post: self.post)
                self.replyComment.likes += 1
                self.replyComment.didLike = true
            }
        }
    }
    
    func checkLike() {
        guard let replyCommentID = replyComment.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }

        Firestore.firestore().collection("replyComments").document(replyCommentID).collection("replyComment-likes").document(userID).getDocument { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let didLike = snap?.exists else { return }
            self.replyComment.didLike = didLike
        }
    }
    
    func unlike() {
        if let didLike = replyComment.didLike, !didLike {
            return
        }
        guard let replyCommentID = replyComment.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }

        Firestore.firestore().collection("replyComments").document(replyCommentID).collection("replyComment-likes").document(userID).delete() { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            Firestore.firestore().collection("users").document(userID).collection("user-likes").document(replyCommentID).delete(){ error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                Firestore.firestore().collection("replyComments").document(replyCommentID).updateData([ "likes": self.replyComment.likes - 1 ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }

                self.replyComment.likes -= 1
                self.replyComment.didLike = false
            }
        }
    }
    
    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 3
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: replyComment.timestamp.dateValue(), to:  Date()) ?? ""
    }
    
    //    var likeText: String {
    //        let label = post.likes == 1 ? "like" : "likes"
    //        return "\(post.likes) \(label)"
    //    }
}
