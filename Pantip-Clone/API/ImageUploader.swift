//
//  ImageUploader.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 19/11/2564 BE.
//

import SwiftUI
import Firebase

struct ImageUploader {
    
    enum UploadType {
        case profile
        case topic
        case comment
        case replycomment
        case message
        
        var filePath: StorageReference {
            let filename = NSUUID().uuidString
            switch self {
            case .profile:
                return Storage.storage().reference(withPath: "/profile_images/\(filename)")
            case .topic:
                return Storage.storage().reference(withPath: "/topic_images/\(filename)")
            case .comment:
                return Storage.storage().reference(withPath: "/comment_images/\(filename)")
            case .replycomment:
                return Storage.storage().reference(withPath: "/reply_comment_images/\(filename)")
            case .message:
                return Storage.storage().reference(withPath: "/message_images/\(filename)")
            }
            
        }
    }
    
    static func uploadImage(image: UIImage, type: UploadType, completion: @escaping (String) -> Void ) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let ref = type.filePath
        
        ref.putData(imageData, metadata: nil) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            ref.downloadURL { (url, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let imageURL = url?.absoluteString else { return }
                
                completion(imageURL)
                
            }
        }
    }
}
