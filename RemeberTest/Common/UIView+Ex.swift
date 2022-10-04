//
//  UIView+Ex.swift
//  RemeberTest
//
//  Created by steve on 2022/09/30.
//

import UIKit

fileprivate let __scale = UIScreen.main.scale

fileprivate
func __pi(_ p: CGFloat) -> CGFloat {
    (round(p * __scale) / __scale)
}

extension CGRect {
    var x: CGFloat {
        get { origin.x }
        set { origin.x = __pi(newValue) }
    }
    var y: CGFloat {
        get { origin.y }
        set { origin.y = __pi(newValue) }
    }
    var w: CGFloat {
        get { size.width }
        set { size.width = __pi(newValue) }
    }
    var h: CGFloat {
        get { size.height }
        set { size.height = __pi(newValue) }
    }

    var width: CGFloat {
        get { w }
        set { w = newValue }
    }
    var height: CGFloat {
        get { h }
        set { h = newValue }
    }

    var left: CGFloat {
        get { x }
        set { x = newValue }
    }
    var right: CGFloat {
        get { x + w }
        set { x = newValue - w }
    }
    var top: CGFloat {
        get { y }
        set { y = newValue }
    }
    var bottom: CGFloat {
        get { y + h }
        set { y = newValue - h }
    }
}

extension UIView {
    var width: CGFloat {
        set { frame.width = newValue }
        get { frame.width }
    }
    var height: CGFloat {
        set { frame.height = newValue }
        get { frame.height }
    }

    var left: CGFloat {
        set { frame.left = newValue }
        get { frame.left }
    }
    var right: CGFloat {
        set { frame.right = newValue }
        get { frame.right }
    }
    var top: CGFloat {
        set { frame.top = newValue }
        get { frame.top }
    }
    var bottom: CGFloat {
        set { frame.bottom = newValue }
        get { frame.bottom }
    }
}
