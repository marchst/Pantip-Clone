//
//  TagViewModel.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI
import Firebase

class TagViewModel: ObservableObject {
    @Published var tags = [Tag]()
    
    init() {
        fetchTags()
    }
    
    func fetchTags() {
        Firestore.firestore().collection("tags").getDocuments { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            
            self.tags = documents.compactMap { try? $0.data(as: Tag.self) }
        }
    }
    
    
}
