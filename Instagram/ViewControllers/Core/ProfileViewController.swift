//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol ProfileViewControllerDelegate: AnyObject {}

class ProfileViewController: UIViewController {
    
    weak var delegate: ProfileViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemRed
    }
}
