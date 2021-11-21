//
//  CountCommentViewModel.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI
import Firebase

class CountCommentViewModel: ObservableObject {
    var topic: Topic
    var comments = [Comment]()
    
    init(topic: Topic) {
        self.topic = topic
        fetchComments()
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
    
    func getCount() -> Int {
        comments.count
    }
}

