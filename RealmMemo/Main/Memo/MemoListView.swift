//
//  MemoListView.swift
//  RealmMemo
//
//  Created by user on 2022/05/10.
//

import SwiftUI

struct MemoListView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(viewModel.memos) { memo in
                        VStack(alignment: .leading, spacing: 10, content: {
                            Text(memo.title)
                            Text(memo.detail)
                                .font(.caption)
                                .foregroundColor(.gray)
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(10)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .contextMenu(menuItems: {
                            Button("메모삭제", action: { viewModel.deleteData(object: memo) })
                            Button("메모수정", action: {
                                viewModel.updateObject = memo
                                viewModel.openNewPage.toggle()
                            })
                        })
                    }
                }
                .padding()
            }
            .navigationBarTitle("메모장")
            .navigationBarItems(trailing: Button(action: { viewModel.openNewPage.toggle() }) {
                Image(systemName: "plus")
                    .font(.title2)
            })
            .sheet(isPresented: $viewModel.openNewPage, content: {
                UpdateView()
                    .environmentObject(viewModel)
            })
        }
        .navigationViewStyle(.stack)
    }
}

struct MemoListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView()
    }
}
