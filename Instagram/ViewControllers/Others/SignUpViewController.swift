//
//  SignUpViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol SignUpViewControllerDelegate: AnyObject {}

class SignUpViewController: UIViewController {
    
    weak var delegate: SignUpViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
}
