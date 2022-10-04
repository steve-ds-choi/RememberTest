//
//  GitHub.swift
//  RemeberTest
//
//  Created by steve on 2022/09/30.
//

import UIKit
import Combine
import RealmSwift

class ItemObj: Object {
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var login = ""
    @Persisted var name  = ""
    
    convenience init(id: Int) {
        self.init()
        self.id = id
    }

    convenience init(item: ListItem) {
        self.init()
        self.id    = item.id
        self.login = item.login
        self.name  = item.name
    }
}

// https://docs.github.com/en/search-github/searching-on-github/searching-users
class GitHubAPI {

    init() {
        loadRealm()
    }

    static let shared = GitHubAPI()

    private let realm = try! Realm()
    private var stars = [Int:ItemObj]()

    var baseURI = "https://api.github.com/"
    var token   = ""

    private
    func toQuery(_ params: Params) -> String {
        params
            .map { "\($0)=\($1)" }
            .joined(separator: "&")
            .asURLQuery
    }

    private
    func toURL(_ uri: String, _ params: Params! = nil) -> URL {
        guard let params = params else { return uri.asURL }
        return "\(uri)?\(toQuery(params))".asURL
    }

    private
    func toURLRequest(uri: String, params: Params!) -> URLRequest {
        let url = toURL(baseURI + uri, params)

        print("request:\(url)")
        
        var request = URLRequest(url: url)
        if token.count > 0 {
            request.setValue("Bearer ghp_" + token, forHTTPHeaderField: "Authorization")
        }
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")

        return request
    }

    private
    func fetch<T: Decodable>(uri: String, params: Params! = nil, _ type: T.Type) -> AnyPublisher<T, Error> {
        let request = toURLRequest(uri: uri, params: params)
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: type, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension GitHubAPI {
    ///https://docs.github.com/en/rest/search#search-users
    func searchUsers<T: Decodable>(_ q: String, page: Int = 1, _ type: T.Type = Users.self) -> AnyPublisher<T, Error> {
        fetch(uri: "search/users",
              params: ["q":"\(q) in:name type:user", "page":page, "per_page":100],
              type)
    }

    ///https://docs.github.com/en/rest/users/users#get-a-user
    func users<T: Decodable>(_ id: String, _ type: T.Type = Users.Info.self) -> AnyPublisher<T, Error> {
        fetch(uri: "users/\(id)", type)
    }
}

///https://realm.io/
extension GitHubAPI {

    private
    func loadRealm() {
        let list = realm.objects(ItemObj.self)
        list.forEach { stars[$0.id!] = $0 }
    }

    func searchLocal(_ name: String) -> AnyPublisher<[ItemObj], Never> {
        let objs = Array(stars.values)
            .filter { name.count == 0 || $0.name.contains(name) }
            .sorted { $0.name < $1.name }

        return Just(objs).eraseToAnyPublisher()
    }

    func setStar(_ item: ListItem, _ isStar: Bool) {
        func appendStar() {
            let obj = ItemObj(item: item)
            stars[item.id] = obj

            try! realm.write {
                realm.add(obj)
            }
        }

        func removeStar() {
            guard let obj = stars[item.id] else { return }

            try! realm.write {
                realm.delete(obj)
                stars.removeValue(forKey: item.id)
            }
        }

        isStar ? appendStar() : removeStar()
    }

    func isStar(_ id: Int) -> Bool { stars[id] != nil }
}

