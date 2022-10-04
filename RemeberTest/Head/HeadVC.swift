//
//  HeadVC.swift
//  RemeberTest
//
//  Created by steve on 2022/09/30.
//

import UIKit
import Combine

class HeadVC: UIViewController {

    @IBOutlet weak var tabs: TabsView!
    @IBOutlet weak var textField: UITextField!

    var tapsPublisher: AnyPublisher<Int, Never>    {
        tabs.$selectedIndex
            .map {
                self.textField.clear()
                return $0
            }
            .eraseToAnyPublisher()
    }
    var textPublisher: AnyPublisher<String, Never> {
        textField.textPublisher
    }

    override
    func viewDidLoad() {
        super.viewDidLoad()
        loadTabs()
    }

    private
    func loadTabs() {
        tabs.add(tab: "API")
        tabs.add(tab: "로컬")
    }
}
