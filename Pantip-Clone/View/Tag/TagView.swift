//
//  TagView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 11/11/2564 BE.
//

import SwiftUI

struct TagView: View {
    @ObservedObject var viewModel = TagViewModel()
    @State var searchText = ""
    @State var user: User
    @State var inSearchMode = false
    var searchTag = "ภาพยนตร์"
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HeaderView(user: user,viewModel: ProfileViewModel(user: user), selectedIndex: .constant(1), searchText: $searchText, inSearchMode: $inSearchMode)
                if inSearchMode {
                    SearchView(searchText: $searchText, inSearchMode: $inSearchMode, searchType: "topic")
                } else {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Text("เลือกดูกระทู้จากแท็ก")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding()
                        ScrollView {
                            VStack {
                                ForEach(viewModel.tags) { tag in
                                    NavigationLink(destination: SearchView(searchText: .constant(tag.name), inSearchMode: .constant(false), searchType: "tag").navigationBarTitleDisplayMode(.inline)) {
                                        Text(tag.name)
                                    }
                                }
                                
                            }
                        }
                    }
                    .background(Color(UIColor(named: "background")!))
                }
            }
            
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
    
}
