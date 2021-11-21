//
//  Tag.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Tag: Decodable, Identifiable {
    let name: String
    @DocumentID var id: String?
    
}
