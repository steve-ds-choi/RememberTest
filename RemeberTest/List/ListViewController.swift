//
//  ListViewController.swift
//  RemeberTest
//
//  Created by steve on 2022/10/01.
//

import UIKit
import Then

class ListViewController: UIViewController {

    lazy var listView = UITableView().then {
        $0.frame = view.bounds
        view.addSubview($0)
        $0.register(cell: ListCell.self)
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 530, right: 0)
    }

    var list: [ListItem]!
    var text = ""

    override
    func viewDidLoad() {
        super.viewDidLoad()
    }

    func reload(list: [ListItem]) {
        self.list = list
        listView.reloadData()
    }
}
