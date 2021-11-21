//
//  FeedViewModel.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class FeedViewModel: ObservableObject {
    @Published var topics = [Topic]()
    
    init() {
        fetchTopics()
    }
    
    func fetchTopics() {
        Firestore.firestore().collection("topics").getDocuments { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            
            self.topics = documents.compactMap { try? $0.data(as: Topic.self) }
        }
    }
    
    func filterTopic(withUid uid: String) -> [Topic] {
        return topics.filter { $0.ownerUID.contains(uid) }
    }
}

