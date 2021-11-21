//
//  FeedCellViewModel.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI
import Firebase
import CoreAudio

class FeedCellViewModel: ObservableObject {
    @Published var topic: Topic
    
    init(topic: Topic) {
        self.topic = topic
        fetchUser()
        checkVote()
        checkLike()
    }
    
    func fetchUser() {
        Firestore.firestore().collection("users").document(topic.ownerUID).getDocument { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.topic.user = try? snap?.data(as: User.self)
            
            guard let userImageURL = self.topic.user?.profileImageURL else { return }
            self.topic.ownerImageURL = userImageURL
        }
    }
    
    func vote() {
        if let didVote = topic.didVote, didVote {
            return
        }
        guard let topicID = topic.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }

        Firestore.firestore().collection("topics").document(topicID).collection("topic-votes").document(userID).setData([:]) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            Firestore.firestore().collection("users").document(userID).collection("user-votes").document(topicID).setData([:]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                Firestore.firestore().collection("topics").document(topicID).updateData([ "votes": self.topic.votes + 1 ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }

//                NotificationsViewModel.sendNotification(withUID: self.post.ownerUID, type: .like, post: self.post)
                self.topic.votes += 1
                self.topic.didVote = true
            }
        }
    }
    
    func checkVote() {
        guard let topicID = topic.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }

        Firestore.firestore().collection("topics").document(topicID).collection("topic-votes").document(userID).getDocument { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let didVote = snap?.exists else { return }
            self.topic.didVote = didVote
        }
    }
    
    func unvote() {
        if let didVote = topic.didVote, !didVote {
            return
        }
        guard let topicID = topic.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }

        Firestore.firestore().collection("topics").document(topicID).collection("topic-votes").document(userID).delete() { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            Firestore.firestore().collection("users").document(userID).collection("user-votes").document(topicID).delete(){ error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                Firestore.firestore().collection("topics").document(topicID).updateData([ "votes": self.topic.votes - 1 ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }

                self.topic.votes -= 1
                self.topic.didVote = false
            }
        }
    }
    
    func like() {
        if let didLike = topic.didLike, didLike {
            return
        }
        guard let topicID = topic.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }

        Firestore.firestore().collection("topics").document(topicID).collection("topic-likes").document(userID).setData([:]) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            Firestore.firestore().collection("users").document(userID).collection("user-likes").document(topicID).setData([:]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                Firestore.firestore().collection("topics").document(topicID).updateData([ "likes": self.topic.likes + 1 ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }

//                NotificationsViewModel.sendNotification(withUID: self.post.ownerUID, type: .like, post: self.post)
                self.topic.likes += 1
                self.topic.didLike = true
            }
        }
    }
    
    func checkLike() {
        guard let topicID = topic.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }

        Firestore.firestore().collection("topics").document(topicID).collection("topic-likes").document(userID).getDocument { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let didLike = snap?.exists else { return }
            self.topic.didLike = didLike
        }
    }
    
    func unlike() {
        if let didLike = topic.didLike, !didLike {
            return
        }
        guard let topicID = topic.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }

        Firestore.firestore().collection("topics").document(topicID).collection("topic-likes").document(userID).delete() { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            Firestore.firestore().collection("users").document(userID).collection("user-likes").document(topicID).delete(){ error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                Firestore.firestore().collection("topics").document(topicID).updateData([ "likes": self.topic.likes - 1 ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }

                self.topic.likes -= 1
                self.topic.didLike = false
            }
        }
    }
    
    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 3
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: topic.timestamp.dateValue(), to:  Date()) ?? ""
    }
    
//    var likeText: String {
//        let label = post.likes == 1 ? "like" : "likes"
//        return "\(post.likes) \(label)"
//    }
}
