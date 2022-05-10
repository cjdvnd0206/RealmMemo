//
//  MainViewModel.swift
//  RealmMemo
//
//  Created by user on 2022/05/10.
//

import SwiftUI
import RealmSwift

final class MainViewModel: ObservableObject {
    private var realm: Realm!
    @Published var title = ""
    @Published var detail = ""
    @Published var openNewPage = false
    @Published var memos = [Memo]()
    @Published var updateObject: Memo?
    
    init() {
        realm = try! Realm()
        fetchData()
    }
    
    private func fetchData() {
        let results = realm.objects(Memo.self)
        
        updateObject = nil
        
        memos = results.compactMap{ memo -> Memo? in
            return memo
        }
    }
    
    func addData(present: Binding<PresentationMode>) {
        let memo = Memo()
        memo.title = title
        memo.detail = detail
        
        try! realm.write {
            guard let updateObject = updateObject else {
                realm.add(memo)
                return
            }
            
            updateObject.title = title
            updateObject.detail = detail
        }
        
        fetchData()
        
        present.wrappedValue.dismiss()
    }
    
    func deleteData(object: Memo) {
        try! realm.write {
            realm.delete(object)
            
            fetchData()
        }
    }
    
    func loadSelectedData() {
        guard let updateObject = updateObject else { return }
        
        title = updateObject.title
        detail = updateObject.detail
    }
    
    func deinitData() {
        title = ""
        detail = ""
    }
}
