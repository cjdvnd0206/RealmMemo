//
//  UpdateView.swift
//  RealmMemo
//
//  Created by user on 2022/05/10.
//

import SwiftUI

struct UpdateView: View {
    @EnvironmentObject private var viewModel: MainViewModel
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("제목")) {
                    TextField("", text: $viewModel.title)
                }
                
                Section(header: Text("내용")) {
                    TextField("", text: $viewModel.detail)
                }
            }
            .listStyle(.grouped)
            .navigationBarTitle(viewModel.updateObject == nil ? "메모추가" : "메모수정", displayMode: .inline)
            .navigationBarItems(leading: Button("취소", action: {
                presentation.wrappedValue.dismiss()
                viewModel.updateObject = nil
            }), trailing: Button("확인", action: { viewModel.addData(present: presentation) }))
        }
        .navigationViewStyle(.stack)
        .onAppear(perform: viewModel.loadSelectedData)
        .onDisappear(perform: viewModel.deinitData)
    }
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView()
    }
}
