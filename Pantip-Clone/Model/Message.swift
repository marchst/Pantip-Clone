//
//  Message.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Message: Decodable, Identifiable, Hashable {
    @DocumentID var id: String?
    let senderID: String
    let receiverID: String
    let title: String
    let message: String
    let timestamp: Timestamp
    let imageURL: String?
    var ownerImageURL: String?
    
    func timestampText() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timestamp.dateValue(), to:  Date()) ?? ""
    }
    
}
