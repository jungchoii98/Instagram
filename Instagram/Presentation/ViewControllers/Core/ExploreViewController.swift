//
//  ExploreViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol ExploreViewControllerDelegate: AnyObject {}

class ExploreViewController: UIViewController {
    
    weak var coordinator: ExploreViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Explore"
        view.backgroundColor = .systemBackground
    }
}
