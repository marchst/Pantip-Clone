//
//  FeedView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 11/11/2564 BE.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel = FeedViewModel()
    @State var inSearchMode = false
    @State var searchText = ""
    @State var user: User
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HeaderView(user: user,viewModel: ProfileViewModel(user: user), selectedIndex: .constant(0), searchText: $searchText, inSearchMode: $inSearchMode)
                if inSearchMode {
                    SearchView(searchText: $searchText, inSearchMode: $inSearchMode, searchType: "topic")
                } else {
                    ScrollView {
                    LazyVStack {

                        ForEach(viewModel.topics) { topic in
                            FeedCell(topic: topic, viewModel: FeedCellViewModel(topic: topic))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    }
                    .background(Color(UIColor(named: "background")!))
                
            }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}


