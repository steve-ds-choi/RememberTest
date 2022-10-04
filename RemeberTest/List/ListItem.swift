//
//  ListItem.swift
//  RemeberTest
//
//  Created by steve on 2022/10/02.
//

import Foundation

class ListItem {

    var id     = 0
    var name   = ""
    var login  = ""
    var isStar = false

    var obj: ItemObj!

    var avartarURL: URL {
        "https://avatars.githubusercontent.com/u/\(id)?v=4".asURL
    }

    init(item: Users.Item, name: String!, _ isStar: Bool = false) {
        self.login  = item.login
        self.id     = item.id
        self.name   = name ?? ""
        self.isStar = isStar
    }

    init(obj: ItemObj, name: String!) {
        self.obj    = obj

        self.login  = obj.login
        self.id     = obj.id!
        self.name   = name ?? ""
        self.isStar = true
    }
}
