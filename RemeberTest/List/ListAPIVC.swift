//
//  ListAPIVC.swift
//  RemeberTest
//
//  Created by steve on 2022/10/03.
//

import UIKit

class ListAPIVC: ListViewController {

    override
    func viewDidLoad() {
        super.viewDidLoad()

        listView.delegate   = self
        listView.dataSource = self
    }
}

extension ListAPIVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = list[indexPath.row]
        let cell = tableView.dequeue(cell: ListCell.self)

        cell.load(item, strongText: text)

        return cell
    }
}
