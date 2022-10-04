//
//  ListLocalVC.swift
//  RemeberTest
//
//  Created by steve on 2022/10/03.
//

import UIKit

class ListLocalVC: ListViewController {

    var lists = [[String:[ListItem]]]()

    override
    func viewDidLoad() {
        super.viewDidLoad()

        listView.delegate   = self
        listView.dataSource = self
    }

    override
    func reload(list: [ListItem]) {
        resort(list)

        super.reload(list: list)
    }

    private
    func resort(_ list: [ListItem]) {
        if list.count == 0 {
            lists.removeAll()
            return
        }

        var chosungs = [String:[ListItem]]()

        for item in list {
            let cho = item.name.asChosung
            if chosungs[cho] == nil {
                chosungs[cho] = [ListItem]()
            }
            chosungs[cho]?.append(item)
        }

        lists = chosungs
            .sorted { $0.key < $1.key }
            .map { [$0.key:$0.value] }
    }
    
    func getKey(_ index: Int) -> String {
        lists[index].keys.first!
    }

    func getList(_ index: Int) -> [ListItem] {
        lists[index].values.first!
    }
}

extension ListLocalVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        lists.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getList(section).count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        getKey(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = getList(indexPath.section)
        let item = list[indexPath.row]

        let cell = tableView.dequeueCell(ListCell.self)
        cell.load(item, strongText: text)

        return cell
    }
}
