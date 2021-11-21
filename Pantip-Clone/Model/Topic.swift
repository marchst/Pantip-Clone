//
//  Topic.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Topic: Decodable, Identifiable {
    @DocumentID var id: String?
    let type: String
    let title: String
    let caption: String
    let timestamp :Timestamp
    var likes: Int
    var funnys: Int
    var loves: Int
    var sads: Int
    var scares: Int
    var wows: Int
    var votes: Int
    let tags: [String?]
    let imageURL: String?
    let ownerUID: String
    var ownerImageURL: String?
    let ownerUsername: String
    
    var user: User?
    var didLike: Bool? = false
    var didVote: Bool? = false
    
//    func timestampText() -> String {
//        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
//        formatter.maximumUnitCount = 2
//        formatter.unitsStyle = .abbreviated
//        return formatter.string(from: timestamp.dateValue(), to:  Date()) ?? ""
//    }
}

