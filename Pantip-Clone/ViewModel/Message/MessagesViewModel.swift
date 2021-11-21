//
//  MessagesViewModel.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI
import Firebase

class MessagesViewModel: ObservableObject {
    let user: User
    
    @Published var messages = [Message]()
    @Published var recievers = [User]()
    init(user: User) {
        self.user = user
        fetchMessage()
//        fetchReciever()
    }
    
    func fetchMessage() {
        guard let senderID = AuthViewModel.shared.userSession?.uid else { return }
        guard let receiverID = user.id else { return }
        
        Firestore.firestore().collection("messages").document(senderID).collection("user-messages").document(receiverID).collection("messages").order(by: "timestamp", descending: false).addSnapshotListener { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documentChanges = snap?.documentChanges.filter({ $0.type == .added }) else { return }
            self.messages.append(contentsOf: documentChanges.compactMap { try? $0.document.data(as: Message.self) })
        }
    }
    
//    func fetchReciever() {
//        guard let senderID = AuthViewModel.shared.userSession?.uid else { return }
//
//        print(senderID)
//
//        let ref = Firestore.firestore().collection("messages").document(senderID).collection("user-messages")
//
//        let a = ref.getDocuments { (snap, error) in
//            if let snap = snap {
//                print(querySnapshot)
//                print(snap.count)
//                for document in querySnapshot.documents {
//                    print("----------")
//                    let id = document.documentID
//                    let username = document.get("username") as! String
//                    print(username)
//                    print("----------")
//                    print(id)
//                    // Do something.
//                }
//            }
//        }
        //            self.recievers.append(contentsOf: documentChanges.compactMap { try? $0.document.data(as: String.self) })
        
        //            for id in documentChanges {
        //                let uid  = id.document.documentID
        //                print(uid)
        //
        //                Firestore.firestore().collection("users").document(uid).getDocument { (snap, error) in
        //                    if let error = error {
        //                        print(error.localizedDescription)
        //                        return
        //                    }
        //                    self.recievers.append(contentsOf: documentChanges.compactMap { try? $0.document.data(as: User.self) })
        //                }
        //            }
        //            print("------------")
        //            print(self.recievers)
//    }
    
    
    func sendMessage(image: UIImage?, title: String, message: String) {
        guard let sender = AuthViewModel.shared.currentUser else { return }
        guard let senderID = sender.id else { return }
        guard let receiverID = user.id else { return }
        
        if image == nil {
            let data: [String: Any] = [
                "senderID": senderID,
                "receiverID": receiverID,
                "title": title,
                "message": message,
                "imageURL": "",
                "timestamp": Timestamp(date: Date()),
                "ownerImageURL": sender.profileImageURL as Any
                
            ]
            
            Firestore.firestore().collection("messages").document(senderID).collection("user-messages").document(receiverID).collection("messages").addDocument(data: data) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                Firestore.firestore().collection("messages").document(receiverID).collection("user-messages").document(senderID).collection("messages").addDocument(data: data) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }
            }
        } else {
            ImageUploader.uploadImage(image: image!, type: .message) { imageURL in
                let data: [String: Any] = [
                    "senderID": senderID,
                    "receiverID": receiverID,
                    "title": title,
                    "message": message,
                    "imageURL": imageURL as Any,
                    "timestamp": Timestamp(date: Date()),
                    "ownerImageURL": sender.profileImageURL as Any
                ]
                
                Firestore.firestore().collection("messages").document(senderID).collection("user-messages").document(receiverID).collection("messages").addDocument(data: data) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    Firestore.firestore().collection("messages").document(receiverID).collection("user-messages").document(senderID).collection("messages").addDocument(data: data) { error in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                    }
                }
                
            }
        }
    }
}
