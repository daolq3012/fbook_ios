//
//  BookDetailViewController.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import Cosmos

class BookDetailViewController: BaseViewController {

    @IBOutlet fileprivate weak var detailTableView: UITableView!

    var presenter: BookDetailPresenter?
    var configurator: BookDetailConfiguratorImplementation?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(viewController: self)
        presenter?.configure(tableView: detailTableView)
        presenter?.fetchBookDetail()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter?.prepare(for: segue, sender: sender)
    }

}

extension BookDetailViewController: BookDetailView {

    func showHideView(_ needToShow: Bool) {
        detailTableView.isHidden = !needToShow
    }

    func updateUI() {
        detailTableView.reloadData()
    }

}
