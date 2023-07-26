//
//  ExploreViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol ExploreViewControllerDelegate: AnyObject {}

class ExploreViewController: UIViewController {
    
    weak var delegate: ExploreViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}
