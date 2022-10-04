//
//  ViewController.swift
//  RemeberTest
//
//  Created by steve on 2022/09/30.
//

import UIKit
import Then
import Combine

class ViewController: UIViewController {

    let headVC      = HeadVC()
    let listAPIVC   = ListAPIVC()
    let listLocalVC = ListLocalVC()

    private var listVC: ListViewController!
    private var vcs = [ListViewController]()

    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var bodyView: UIView!

    private var cancelBag = Set<AnyCancellable>()

    override
    func viewDidLoad() {
        super.viewDidLoad()

        GitHubAPI.shared.token = "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"

        loadHead()
        loadBody()
        loadBind()
    }

    private
    func loadHead() {
        headVC.view.frame = headView.bounds
        headView.addSubview(headVC.view)
    }

    private
    func setBody(_ index: Int) {
        vcs.forEach { $0.view.isHidden = true }

        listVC = vcs[index]
        listVC.view.isHidden = false
    }

    private
    func loadBody() {
        func addBody(vc: ListViewController) {
            vc.view.frame = bodyView.bounds
            bodyView.addSubview(vc.view)
            vcs.append(vc)
        }

        addBody(vc: listAPIVC)
        addBody(vc: listLocalVC)

        setBody(0)
    }
}

extension ViewController {

    private
    func loadBind() {
        headVC.tapsPublisher
            .sink {
                self.reload(mode: $0)
            }
            .store(in: &cancelBag)

        headVC.textPublisher
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
            .sink {
                self.reload(text: $0)
            }
            .store(in: &cancelBag)

        GitHubManager.shared.$list
            .sink {
                self.reload(list: $0)
            }
            .store(in: &cancelBag)
    }

    private
    func reload(mode: Int) {
        GitHubManager.shared.searchMode = mode == 0 ? .Network : .Local
        setBody(mode)

        reload(text: "")
    }

    private
    func reload(list: [ListItem]) {
        listVC.reload(list: list)
    }

    private
    func reload(text: String) {
        listVC.text = text
        if text.count == 0 {
            listVC.reload(list: [])
        }
        GitHubManager.shared.searchUsers(text)
    }
}
