//
//  UploadTopicViewModel.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI
import Firebase

class UploadTopicViewModel: ObservableObject {
    func uploadTopic(image: UIImage?,type: String, title: String, caption: String, tags: [String?]) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        if image == nil {
            guard let uid = user.id else { return }
            let data = [
                "type": type,
                "title": title,
                "caption": caption,
                "timestamp": Timestamp(date: Date()),
                "likes": 0,
                "funnys": 0,
                "loves": 0,
                "sads": 0,
                "scares": 0,
                "wows": 0,
                "votes": 0,
                "tags": tags,
                "imageURL": "",
                "ownerUID": uid,
                "ownerUsername": user.username
            ] as [String: Any]
            
            Firestore.firestore().collection("topics").addDocument(data: data) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }

            
        } else {
            ImageUploader.uploadImage(image: image!, type: .topic) { imageURL in
                guard let uid = user.id else { return }
                
                let data = [
                    "type": type,
                    "title": title,
                    "caption": caption,
                    "timestamp": Timestamp(date: Date()),
                    "likes": 0,
                    "funnys": 0,
                    "loves": 0,
                    "sads": 0,
                    "scares": 0,
                    "wows": 0,
                    "votes": 0,
                    "tags": tags,
                    "imageURL": imageURL as Any,
                    "ownerUID": uid,
                    "ownerUsername": user.username
                ] as [String: Any]
                
                Firestore.firestore().collection("topics").addDocument(data: data) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }
            }
        }
    }
}
