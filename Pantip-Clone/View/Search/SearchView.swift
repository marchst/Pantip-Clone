//
//  SearchView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 21/11/2564 BE.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    @Binding var searchText: String
    @Binding var inSearchMode: Bool
    @State var searchType: String
    var body: some View {
//        ScrollView {
            ZStack {
                TopicListView(viewModel: viewModel, searchText: $searchText, searchType: searchType)

            }
//        }
        .background(Color(UIColor(named: "background")!))
        
    }
}
