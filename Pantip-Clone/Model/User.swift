//
//  User.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 16/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct User: Decodable, Identifiable {
    let username: String
    let email: String
    let fullname: String
    var profileImageURL: String?
    @DocumentID var id: String?
    
    mutating func updateProfileImageURL(url: String) {
        profileImageURL = url
    }
    
    var isCurrentUser: Bool {
        AuthViewModel.shared.userSession?.uid == id
    }
    
    var didFollow: Bool? = false
    var bio: String?
}
