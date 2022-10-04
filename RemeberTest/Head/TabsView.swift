//
//  TabsView.swift
//  RemeberTest
//
//  Created by steve on 2022/10/01.
//

import UIKit
import Combine

private
class Item {
    var tag    = 0
    var text   = ""
    var button = UIButton()

    init(_ text: String, tag: Int) {
        self.text = text
        self.tag  = tag
    }
}

class TabsView: UIView {

    private var items = [Item]()

    private var cancelBag = Set<AnyCancellable>()
    @Published var selectedIndex = 0

    lazy var line = UIView().then {
        $0.isUserInteractionEnabled = false
        $0.backgroundColor = .blue
        $0.height = 3
        addSubview($0)
    }

    func add(tab: String) {
        let item = Item(tab, tag: items.count)
        items.append(item)
    }

    private
    func loadButton(_ tag: Int, _ item: Item, _ frame: CGRect) {
        let button = item.button
        button.frame = frame

        if button.superview == self { return }

        button.setTitle(item.text, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tapPublisher
            .sink { _ in
                self.selectedIndex = tag
                self.loadLine()
            }
            .store(in: &cancelBag)

        addSubview(button)
    }

    private
    func loadButtons() {
        let itemW = width / items.count.asFloat
        var frame = bounds
        frame.w = itemW

        items.enumerated().forEach {
            loadButton($0, $1, frame)
            frame.x += itemW
        }
    }

    private
    func loadLine() {
        let item   = items[selectedIndex]
        let button = item.button

        line.left   = button.left
        line.width  = button.width
        line.bottom = button.bottom
    }

    override
    func layoutSubviews() {
        loadButtons()
        loadLine()
    }
}
