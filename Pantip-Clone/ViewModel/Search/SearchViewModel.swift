//
//  SearchViewModel.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI
import Firebase

class SearchViewModel: ObservableObject {
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
    
    func filterTopics(withText input: String) -> [Topic] {
        let lowercasedInput = input.lowercased()
        return topics.filter { $0.title.lowercased().contains(lowercasedInput) || $0.caption.lowercased().contains(lowercasedInput) }
    }
    
    func filterTags(withText input: String) -> [Topic] {
        let lowercasedInput = input.lowercased()
        
        return topics.filter { $0.tags[0]!.lowercased().contains(lowercasedInput) || $0.tags[1]!.lowercased().contains(lowercasedInput) || $0.tags[2]!.lowercased().contains(lowercasedInput) || $0.tags[3]!.lowercased().contains(lowercasedInput) || $0.tags[4]!.lowercased().contains(lowercasedInput) }
    }
}
