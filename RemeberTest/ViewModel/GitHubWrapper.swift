//
//  GitHubWrapper.swift
//  RemeberTest
//
//  Created by steve on 2022/10/04.
//

import UIKit

struct GitHubWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

protocol GitHubCompatible: AnyObject { }

extension GitHubCompatible {
    var gh: GitHubWrapper<Self> {
        get { GitHubWrapper(self) }
        set { }
    }
}

extension GitHubWrapper where Base: UILabel {
    func setName(with login: String, _ strongText: String) {
        GitHubManager.shared.loadName(base, login, strongText)
    }
}

extension UILabel: GitHubCompatible { }

