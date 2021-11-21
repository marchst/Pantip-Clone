//
//  ProfileViewModel.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 19/11/2564 BE.
//

import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func changeProfileImage(image: UIImage) {
        ImageUploader.uploadImage(image: image, type: .profile) { imageURL in
            guard let uid = self.user.id else { return }
            Firestore.firestore().collection("users").document(uid).updateData([
                "profileImageURL": imageURL
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                self.user.updateProfileImageURL(url: imageURL)
            }
        }
    }
}
