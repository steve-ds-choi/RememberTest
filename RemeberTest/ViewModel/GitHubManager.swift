//
//  ViewModel.swift
//  RemeberTest
//
//  Created by steve on 2022/09/30.
//

import UIKit
import Combine

class GitHubManager {
    enum SearchMode {
        case Local, Network
    }
    static let shared = GitHubManager()

    @Published var list = [ListItem]()

    var searchMode = SearchMode.Network

    private var names      = [String:String]()
    private var cancelBag  = Set<AnyCancellable>()
    private var namesBag   = [Int:AnyCancellable]()

    func searchUsers(_ name: String) {

        if searchMode == .Local {
            GitHubAPI.shared.searchLocal(name)
                .sink {
                    self.list = $0.map {
                        var name = $0.name
                        if name.count == 0 { name = self.names[$0.login] ?? "" }
                        return ListItem(obj: $0, name: name)
                    }
                }
                .store(in: &cancelBag)
            return
        }

        if name.count == 0 { return }

        // steve,35, 는 에러가 나고 있다 -> API limit 1000인 걸로 확인됨
        GitHubAPI.shared.searchUsers(name, page: 1)
            .sink { _ in
            } receiveValue: {
                self.list = $0.items.map {
                    let isStar = GitHubAPI.shared.isStar($0.id)
                    return ListItem(item: $0, name: self.names[$0.login], isStar)
                }
            }
            .store(in: &cancelBag)
    }

    func setStar(_ item: ListItem, _ isStar: Bool) {
        item.isStar = isStar
        item.name   = names[item.login] ?? ""
        GitHubAPI.shared.setStar(item, isStar)

        if searchMode == .Local, isStar == false {
            list = list.filter { $0.id != item.id }
        }
    }
}

extension GitHubManager {
    func loadName(_ label: UILabel, _ login: String, _ strongText: String) {
        if let bag = namesBag[label.hash] {
            bag.cancel()
            namesBag.removeValue(forKey: label.hash)
        }

        if let name = names[login] {
            label.setAttrText(name, attr: strongText, color: .red)
            return
        }

        label.text = login

        namesBag[label.hash] =
        GitHubAPI.shared.users(login)
            .sink { _ in
            } receiveValue: {
                self.names[login] = $0.name
                label.setAttrText($0.name, attr: strongText, color: .red)
            }
    }
}
