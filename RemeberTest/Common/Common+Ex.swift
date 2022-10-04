//
//  Common+Ex.swift
//  RemeberTest
//
//  Created by steve on 2022/09/30.
//

import UIKit

public typealias Params = [String: Any]

extension Int {
    var asFloat: CGFloat { CGFloat(self) }
}

extension Array where Element: Equatable {

    mutating
    func remove(_ obj: Element) {
        guard let index = firstIndex(of:obj) else { return }
        remove(at:index)
    }

    mutating
    func remove(array:Array) {
        if array.count == 0 { return }
        self = filter { !array.contains($0) }
    }
}
