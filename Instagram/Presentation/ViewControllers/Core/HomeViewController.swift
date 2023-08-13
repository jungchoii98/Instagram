//
//  HomeViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {}

class HomeViewController: UIViewController {
    
    weak var coordinator: HomeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
    }
}

