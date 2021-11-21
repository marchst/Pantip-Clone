//
//  SelectTagView.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 20/11/2564 BE.
//

import SwiftUI

struct SelectTagView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = TagViewModel()
    @Binding var tags: [String]
    var body: some View {
        List {
            ForEach(viewModel.tags) { tag in
                    Button {
                        tags[0] = tag.name
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text(tag.name)
                    }
            
            }
        }
    }
}

