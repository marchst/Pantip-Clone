//
//  ReplyComment.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ReplyComment: Decodable, Identifiable {
    @DocumentID var id: String?
    let replyComment: String
    let uid: String
    let timestamp: Timestamp
    var likes: Int
    var funnys: Int
    var loves: Int
    var sads: Int
    var scares: Int
    var wows: Int
    var votes: Int
    let imageURL: String?
    let commentOwnerID: String
    let username: String
    var profileImageURL: String?
    
    var user: User?
    var didLike: Bool? = false
    var didVote: Bool? = false
}

