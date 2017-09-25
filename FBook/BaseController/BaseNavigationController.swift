//
//  BaseNavigationController.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
    }

    func setUpNavigation() {
        navigationBar.barTintColor = .red
        navigationBar.tintColor = .white
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationBar.backIndicatorImage = #imageLiteral(resourceName: "ic_back")
        navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "ic_back")
    }

}
