//
//  ListCell.swift
//  RemeberTest
//
//  Created by steve on 2022/10/02.
//

import UIKit
import Kingfisher

class ListCell: UITableViewCell {

    @IBOutlet weak var ivThumb: UIImageView!
    @IBOutlet weak var lbLabel: UILabel!
    @IBOutlet weak var btStar: UIButton!

    var item: ListItem!

    func load(_ item: ListItem, strongText: String) {
        self.item = item

        clear()

        ivThumb.kf.setImage(with: item.avartarURL)
        lbLabel.gh.setName(with:  item.login, strongText)

        loadStar()
    }

    func clear() {
        ivThumb.image = nil
        lbLabel.attributedText = NSMutableAttributedString(string:"")
    }

    private
    func loadStar() {
        let image = UIImage(systemName: item.isStar ? "star.fill" : "star")
        btStar.setImage(image, for: .normal)
    }

    @IBAction
    func btStar(_ sender: Any) {
        GitHubManager.shared.setStar(item, !item.isStar)
        loadStar()
    }
}
