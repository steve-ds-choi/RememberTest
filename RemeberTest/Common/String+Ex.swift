//
//  String+Ex.swift
//  RemeberTest
//
//  Created by steve on 2022/09/30.
//

import Foundation

private let chosungs = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]

extension String {

    var asNSString: NSString { self as NSString }

    var asURLQuery: String {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }

    var asURL: URL {
        URL(string: self) ?? URL(string: "https://")!
    }

    var asChosung: String {
        if count == 0 { return "*" }

        let code = unicodeScalars.first!

        // 한글인지 검사
        if 0xAC00...0xD7A3 ~= code.value {
            let index = (code.value - 0xAC00) / 28 / 21
            return chosungs[Int(index)]
        }

        if code.properties.isAlphabetic {
            return String(code).uppercased()
        }

        return "*"
    }

    func range(of str: String, _ mask: NSString.CompareOptions = []) -> NSRange {
        asNSString.range(of: str, options: mask)
    }

    func range(of str: String, _ mask: NSString.CompareOptions = [], _ range: NSRange) -> NSRange {
        asNSString.range(of: str, options: mask, range: range)
    }
}
