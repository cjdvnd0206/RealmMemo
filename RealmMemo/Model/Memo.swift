//
//  Memo.swift
//  RealmMemo
//
//  Created by user on 2022/05/10.
//

import Foundation
import RealmSwift

class Memo: Object, Identifiable {
    @objc dynamic var id: Date = Date()
    @objc dynamic var title = ""
    @objc dynamic var detail = ""
    // Git PR Test
}
