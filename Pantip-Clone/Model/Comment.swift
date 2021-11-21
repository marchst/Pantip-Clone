//
//  Comment.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Comment: Decodable, Identifiable {
    @DocumentID var id: String?
    let comment: String
    let uid: String
    let timestamp :Timestamp
    var likes: Int
    var funnys: Int
    var loves: Int
    var sads: Int
    var scares: Int
    var wows: Int
    var votes: Int
    let imageURL: String?
    let topicOwnerID: String
    let username: String
    var profileImageURL: String?
    
    var user: User?
    var didLike: Bool? = false
    var didVote: Bool? = false
}
